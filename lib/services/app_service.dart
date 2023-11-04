import 'dart:async';
import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gestures/models/app_content.dart';
import 'package:gestures/models/gesture.dart';
import 'package:gestures/models/package.dart';
import 'package:universal_html/html.dart' as html;

class AppService {
  static final _gestureIdRegex = RegExp(r'^Gebärden\/(?<id>.*\/.*)\.mp4$');

  Future<AppContent>? _loadFuture;

  Future<AppContent> _loadCachedAppContent() async {
    final storage = FirebaseStorage.instance;
    final ref = storage.ref('appContent.json');
    final bytes = await ref.getData();
    if (bytes == null) throw Exception('Cached app content not available.');
    final json = jsonDecode(utf8.decode(bytes));
    return AppContent.fromJson(json);
  }

  Future<AppContent> _loadLiveAppContent(BuildContext context) async {
    final packages = await _loadLivePackages(context);
    return AppContent(packages: packages);
  }

  Future<List<Package>> _loadLivePackages(BuildContext context) async {
    final allSynonyms = await _loadAllSynonymsFromAssets(context);

    final storage = FirebaseStorage.instance;
    final root = storage.ref(Gesture.rootDirectory);
    final rootItems = await root.listAll();
    final List<Package> packages = [];
    for (final packageRef in rootItems.prefixes) {
      packages.add(
        await _mapPackageRef(
          packageRef: packageRef,
          allSynonyms: allSynonyms,
        ),
      );
    }
    return packages;
  }

  Future<Map<String, List<String>>> _loadAllSynonymsFromAssets(
    BuildContext context,
  ) async {
    final text =
        await DefaultAssetBundle.of(context).loadString('assets/synonyms.json');
    return (jsonDecode(text) as Map).map(
      (key, value) => MapEntry(
        key as String,
        (value as List).map((item) => item as String).toList(),
      ),
    );
  }

  Future<Package> _mapPackageRef({
    required Reference packageRef,
    required Map<String, List<String>> allSynonyms,
  }) async {
    final packageItems = await packageRef.listAll();
    final videoFiles =
        packageItems.items.where((itemRef) => itemRef.name.endsWith('.mp4'));
    return Package(
      id: packageRef.name,
      gestures: videoFiles
          .map(
            (gestureRef) => _mapGestureRef(
              gestureRef: gestureRef,
              allSynonyms: allSynonyms,
            ),
          )
          .toList(),
    );
  }

  Gesture _mapGestureRef({
    required Reference gestureRef,
    required Map<String, List<String>> allSynonyms,
  }) {
    final id =
        _gestureIdRegex.firstMatch(gestureRef.fullPath)?.namedGroup('id');
    assert(
      id != null,
      'Unable to find gesture ID in path ${gestureRef.fullPath}.',
    );

    return Gesture(
      id: id!,
      synonyms: allSynonyms[id],
    );
  }

  Future<AppContent> getAppContent(BuildContext context) async {
    if (_loadFuture != null) return await _loadFuture!;

    try {
      _loadFuture = _loadCachedAppContent();
      return await _loadFuture!;
    } catch (e, stackTrace) {
      // ignore: avoid_print
      print('Loading cached content failed: $e.');
      // ignore: avoid_print
      print(stackTrace);
    }

    // ignore: avoid_print
    print('Loading live content as a fallback...');

    try {
      _loadFuture = _loadLiveAppContent(context);
      return await _loadFuture!;
    } catch (e, stackTrace) {
      // ignore: avoid_print
      print('Loading live content failed: $e.');
      // ignore: avoid_print
      print(stackTrace);
      rethrow;
    }
  }

  Future<List<Package>> getPackages(BuildContext context) async {
    final appContent = await getAppContent(context);
    return appContent.packages;
  }

  Future<Package> getPackage(
    BuildContext context, {
    required String packageId,
  }) async {
    final packages = await getPackages(context);
    return packages.firstWhere((package) => package.title == packageId);
  }

  Future<List<Gesture>> getAllGestures(BuildContext context) async {
    final packages = await getPackages(context);
    final allGestures = [...packages.expand((p) => p.gestures)];
    allGestures.sort((g1, g2) => g1.title.compareTo(g2.title));
    return allGestures;
  }

  Future<Gesture> getGesture(
    BuildContext context, {
    required String packageId,
    required String gestureId,
  }) async {
    final package = await getPackage(context, packageId: packageId);
    return package.gestures.firstWhere((gesture) => gesture.title == gestureId);
  }

  Future<void> exportLiveAppContent(BuildContext context) async {
    final appContentFuture = _loadLiveAppContent(context);
    final appContent = await appContentFuture;
    List<int> bytes = utf8.encode(jsonEncode(appContent.toJson()));
    final blob = html.Blob([bytes], 'application/json');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, '_blank');
    html.Url.revokeObjectUrl(url);
  }
}

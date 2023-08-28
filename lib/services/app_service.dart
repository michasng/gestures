import 'dart:async';
import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:gestures/models/gesture.dart';
import 'package:gestures/models/package.dart';

class AppService {
  final _gestureTitleRegex = RegExp(r'(?<title>.*)\.mp4');

  Future<List<Package>>? _loadFuture;

  Future<List<Package>> loadPackages(
    BuildContext context,
  ) async {
    return _loadFuture ??= _loadPackages(context);
  }

  Future<Package> loadPackage(
    BuildContext context, {
    required String packageId,
  }) async {
    final packages = await loadPackages(context);

    if (packageId == Package.allGesturesPackageTitle)
      return createAllGesturesPackage(packages);

    return packages.firstWhere((package) => package.title == packageId);
  }

  Future<Gesture> loadGesture(
    BuildContext context, {
    required String packageId,
    required String gestureId,
  }) async {
    final package = await loadPackage(context, packageId: packageId);
    return package.gestures.firstWhere((gesture) => gesture.title == gestureId);
  }

  Future<List<Package>> _loadPackages(BuildContext context) async {
    final synonyms = await _loadSynonyms(context);

    final storage = FirebaseStorage.instance;
    final root = storage.ref('/Gebärden');
    final rootItems = await root.listAll();
    final List<Package> packages = [];
    for (final packageRef in rootItems.prefixes) {
      packages.add(await _mapPackageRef(packageRef, synonyms));
    }
    return packages;
  }

  Package createAllGesturesPackage(List<Package> packages) {
    final allGestures = [...packages.expand((p) => p.gestures)];
    allGestures.sort((g1, g2) => g1.title.compareTo(g2.title));
    return Package(
      title: Package.allGesturesPackageTitle,
      gestures: allGestures,
    );
  }

  Future<Map<String, List<String>>> _loadSynonyms(BuildContext context) async {
    final text =
        await DefaultAssetBundle.of(context).loadString('assets/synonyms.json');
    return (jsonDecode(text) as Map).map(
      (key, value) => MapEntry(
        key as String,
        (value as List).map((item) => item as String).toList(),
      ),
    );
  }

  Future<Package> _mapPackageRef(
    Reference packageRef,
    Map<String, List<String>> synonyms,
  ) async {
    final packageItems = await packageRef.listAll();
    final videoFiles =
        packageItems.items.where((itemRef) => itemRef.name.endsWith('.mp4'));
    return Package(
      title: packageRef.name,
      gestures: videoFiles
          .map((gestureRef) => _mapGestureRef(gestureRef, synonyms))
          .toList(),
    );
  }

  Gesture _mapGestureRef(
    Reference gestureRef,
    Map<String, List<String>> synonyms,
  ) {
    return Gesture(
      title:
          _gestureTitleRegex.firstMatch(gestureRef.name)?.namedGroup('title') ??
              gestureRef.name,
      storageReference: gestureRef,
      synonyms: synonyms[gestureRef.fullPath] ?? [],
    );
  }
}

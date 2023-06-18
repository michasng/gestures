import 'dart:async';
import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:gestures/models/app_content.dart';
import 'package:gestures/models/gesture.dart';
import 'package:gestures/models/package.dart';

class AppService {
  final _gestureTitleRegex = RegExp(r'(?<title>.*)\.mp4');

  Future<AppContent> load(BuildContext context) async {
    final synonyms = await _loadSynonyms(context);

    final storage = FirebaseStorage.instance;
    final root = storage.ref('/Gebärden');
    final rootItems = await root.listAll();
    final List<Package> packages = [];
    for (final packageRef in rootItems.prefixes) {
      packages.add(await _mapPackageRef(packageRef, synonyms));
    }
    return AppContent(packages: packages);
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

import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:gestures/models/app_content.dart';
import 'package:gestures/models/gesture.dart';
import 'package:gestures/models/package.dart';
import 'package:gestures/services/responses/storage_objects_response/storage_object_item.dart';
import 'package:gestures/services/responses/storage_objects_response/storage_objects_response.dart';
import 'package:http/http.dart' as http;

class AppService {
  final http.Client _client;
  static const _scheme = 'https';
  static const _host = 'storage.googleapis.com';
  static const _bucket = 'ursberger-gebaerden.appspot.com';
  static const _wordPattern = r'[A-Za-zÀ-ž\u0370-\u03FF\u0400-\u04FF\s\d\-\(\)]+';
  static const _mp4FileExtensionPattern = r'\.mp4';
  static const _fileSeparatorPattern = r'\/';
  static const _mp4FileNamePattern = '($_wordPattern)$_mp4FileExtensionPattern';
  final _packageTitleRegex =
      RegExp('($_wordPattern)$_fileSeparatorPattern$_mp4FileNamePattern');
  final _gestureTitleRegex = RegExp(_mp4FileNamePattern);

  AppService() : _client = http.Client();

  Future<AppContent> load(BuildContext context) async {
    var storageObjects = await _findStorageObjects();
    return _mapToAppContent(storageObjects);
  }

  Future<StorageObjectsResponse> _findStorageObjects() async {
    final rawResponse = await _client.get(
      Uri(
        scheme: _scheme,
        host: _host,
        path: 'storage/v1/b/ursberger-gebaerden.appspot.com/o',
        queryParameters: {
          'prefix': 'Gebärden/',
        },
      ),
    );
    final decodedResponse =
        jsonDecode(rawResponse.body) as Map<String, dynamic>;
    return StorageObjectsResponse.fromJson(decodedResponse);
  }

  AppContent _mapToAppContent(StorageObjectsResponse storageObjects) {
    final Map<String, List<Gesture>> packageTitleToGestures = {};
    final videoFileItems =
        storageObjects.items.where((item) => item.contentType == 'video/mp4');
    for (var item in videoFileItems) {
      final gesture = _mapGesture(item);
      final packageTitle =
          _packageTitleRegex.firstMatch(item.name)?.group(1) ?? item.name;
      packageTitleToGestures.putIfAbsent(packageTitle, () => <Gesture>[]);
      packageTitleToGestures[packageTitle]!.add(gesture);
    }
    final packages = packageTitleToGestures.keys.map(
      (packageTitle) => Package(
        title: packageTitle,
        gestures: packageTitleToGestures[packageTitle]!,
      ),
    );
    return AppContent(packages: packages.toList());
  }

  Gesture _mapGesture(StorageObjectItem item) {
    final encodedFilePath = Uri.encodeComponent(item.name);
    final gestureTitle =
        _gestureTitleRegex.firstMatch(item.name)?.group(1) ?? item.name;
    return Gesture(
      title: gestureTitle,
      directLink: '$_scheme://$_host/$_bucket/$encodedFilePath',
      synonyms: _mapSynonyms(item),
    );
  }

  List<String> _mapSynonyms(StorageObjectItem item) {
    return item.metadata?.synonyms
            ?.split(',')
            .map((synonym) => synonym.trim())
            .toList() ??
        [];
  }
}

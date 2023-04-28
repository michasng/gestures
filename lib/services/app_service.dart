import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:gestures/models/app_content.dart';
import 'package:gestures/models/gesture.dart';
import 'package:gestures/models/package.dart';

class AppService {
  Future<Map<String, List<String>>> _prepareSynonyms(
    dynamic synonymsConfig,
  ) async {
    final Map<String, List<String>> mappedSynonyms = {};
    for (final entry in synonymsConfig) {
      mappedSynonyms[entry['title']] = (entry['synonyms'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [];
    }
    return mappedSynonyms;
  }

  Future<AppContent> load(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final config =
        jsonDecode(await assetBundle.loadString('assets/config.json'));
    final mappedSynonyms = await _prepareSynonyms(config['synonyms']);

    final json = jsonDecode(
      await assetBundle
          .loadString('assets/1kmmmdsYyvc9eMYy_UFLnfAu28DEUuU11.json'),
    );
    List<Package> packages = [];
    for (final packageFileItem in json['files']) {
      String packageMimeType = packageFileItem['mimeType'];
      if (packageMimeType != 'application/vnd.google-apps.folder') continue;
      String packageId = packageFileItem['id'];
      String packageName = packageFileItem['name'];
      dynamic packageJson;
      try {
        packageJson = jsonDecode(
          await assetBundle.loadString('assets/packages/$packageId.json'),
        );
      } catch (e) {
        print(e);
        continue;
      }

      List<Gesture> gestures = [];
      for (final fileItem in packageJson['files']) {
        String mimeType = fileItem['mimeType'];
        if (mimeType != 'video/mp4') continue;
        String id = fileItem['id'];
        String filename = fileItem['name'];
        String title = filename.replaceAll(RegExp(r'\.mp4'), '');
        String sharingLink =
            'https://drive.google.com/file/d/$id/view?usp=sharing';

        gestures.add(
          Gesture(
            title: title,
            filename: filename,
            sharingLink: sharingLink,
            synonyms: mappedSynonyms[title] ?? [],
          ),
        );
      }

      packages.add(
        Package(
          title: packageName,
          gestures: gestures,
        ),
      );
    }

    return AppContent(packages: packages);
  }
}

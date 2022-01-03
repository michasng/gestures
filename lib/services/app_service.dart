import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:gestures/models/app_content.dart';
import 'package:provider/provider.dart';

class AppService {
  late final AppContent content;

  AppService(this.content);

  static Future<AppService> load(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/app_content.json');
    final json = jsonDecode(data);
    final content = AppContent.fromJson(json);
    return AppService(content);
  }

  static AppService of(BuildContext context) {
    return Provider.of<AppService>(context, listen: false);
  }
}

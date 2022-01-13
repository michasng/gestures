import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestures/models/app_content.dart';
import 'package:gestures/screens/error/error_screen.dart';
import 'package:gestures/screens/home/home_screen.dart';
import 'package:gestures/screens/loading/loading_screen.dart';
import 'package:gestures/services/google_drive_service.dart';
import 'package:gestures/services/search_service.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.I.registerSingleton<SearchService>(SearchService());
  GetIt.I.registerSingleton<GoogleDriveService>(GoogleDriveService(
    apiKey: 'AIzaSyBVjAU58Izq4tLrpUCxbqyyt2iOFroJc88',
  ));

  runApp(const App());
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  Future<AppContent> _load(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/app_content.json');
    final json = jsonDecode(data);
    return AppContent.fromJson(json);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ursberger Gebärden',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: FutureBuilder<AppContent>(
        future: _load(context),
        builder: (context, snapshot) {
          if (snapshot.hasError) return ErrorScreen(error: snapshot.error!);

          if (!snapshot.hasData) return const LoadingScreen();

          return HomeScreen(appContent: snapshot.data!);
        },
      ),
    );
  }
}

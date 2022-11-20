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
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/app_content.json');
    final json = jsonDecode(data);
    return AppContent.fromJson(json);
  }

  MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xff434b56);

    return MaterialApp(
      title: 'Ursberger Gebärden',
      theme: ThemeData(
        primarySwatch: _createMaterialColor(backgroundColor),
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

import 'package:flutter/material.dart';
import 'package:gestures/models/app_content.dart';
import 'package:gestures/screens/error/error_screen.dart';
import 'package:gestures/screens/home/home_screen.dart';
import 'package:gestures/screens/loading/loading_screen.dart';
import 'package:gestures/services/app_service.dart';
import 'package:gestures/services/search_service.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.I.registerSingleton<AppService>(AppService());
  GetIt.I.registerSingleton<SearchService>(SearchService());

  runApp(const App());
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ursberger Gebärden',
      theme: ThemeData.from(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xffdab88b),
          onPrimary: Colors.white,
          secondary: Color(0xffc4772a),
          onSecondary: Colors.white,
          error: Color(0xffe4db6b),
          onError: Colors.white,
          background: Color(0xfff3e9dd),
          onBackground: Color(0xff4d4d4d),
          surface: Color(0xfffdf6ec),
          onSurface: Color(0xff4d4d4d),
        ),
      ),
      home: FutureBuilder<AppContent>(
        future: GetIt.I<AppService>().load(context),
        builder: (context, snapshot) {
          if (snapshot.hasError) return ErrorScreen(error: snapshot.error!);

          if (!snapshot.hasData) return const LoadingScreen();

          return HomeScreen(appContent: snapshot.data!);
        },
      ),
    );
  }
}

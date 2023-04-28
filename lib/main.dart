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
          primary: Color(0xff434b56),
          onPrimary: Colors.white,
          secondary: Color(0xfff5Cf77),
          onSecondary: Colors.black,
          error: Color(0xff8c403e),
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          surface: Color(0xffd2d2d2),
          onSurface: Colors.black,
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

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gestures/components/auth_state_builder.dart';
import 'package:gestures/firebase_options.dart';
import 'package:gestures/models/app_content.dart';
import 'package:gestures/screens/error/error_screen.dart';
import 'package:gestures/screens/home/home_screen.dart';
import 'package:gestures/screens/loading/loading_screen.dart';
import 'package:gestures/screens/login/login_screen.dart';
import 'package:gestures/services/app_service.dart';
import 'package:gestures/services/search_service.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  GetIt.I.registerSingleton<AppService>(AppService());
  GetIt.I.registerSingleton<SearchService>(SearchService());

  runApp(const App());
}

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ursberger Gebärden',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        textTheme: GoogleFonts.spectralTextTheme(),
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xffdab88b),
          onPrimary: Colors.white,
          secondary: Color(0xffaa885b),
          onSecondary: Colors.white,
          error: Color(0xffd45b3b),
          onError: Colors.white,
          background: Color(0xfff3e9dd),
          onBackground: Color(0xff4d4d4d),
          surface: Color(0xfffdf6ec),
          onSurface: Color(0xff4d4d4d),
        ),
      ).copyWith(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xffaa885b),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: AuthStateBuilder(
        loadingBuilder: (_) => const LoadingScreen(),
        errorBuilder: (_, error) => ErrorScreen(error: error),
        unauthenticatedBuilder: (_) => LoginScreen(),
        authenticatedBuilder: (_, user) {
          return FutureBuilder<AppContent>(
            future: GetIt.I<AppService>().load(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return const LoadingScreen();

              if (snapshot.hasError) return ErrorScreen(error: snapshot.error!);

              return HomeScreen(appContent: snapshot.data!);
            },
          );
        },
      ),
    );
  }
}

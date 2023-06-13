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
    // DRW corporate design
    final primaryColor = Color(0xffa60430);
    final accentColor = Color(0xffedd7d5);
    // final surfaceColor = Color(0xfff0f0ed);
    // final surfaceColor2 = Color(0xffe1e1dd);
    const backgroundColor = Colors.white;

    // not defined in corporate design
    const onLightColor = Color(0xff4d4d4d);
    const onDarkColor = Colors.white;

    return MaterialApp(
      title: 'Ursberger Gebärden',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        textTheme: GoogleFonts.firaSansTextTheme(),
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: onDarkColor,
          secondary: accentColor,
          onSecondary: onLightColor,
          error: primaryColor,
          onError: onDarkColor,
          background: backgroundColor,
          onBackground: onLightColor,
          // using backgroundColor as surfaceColor, because of the BG image
          surface: backgroundColor.withAlpha(216),
          onSurface: onLightColor,
        ),
      ).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          toolbarHeight: 64,
          backgroundColor: primaryColor,
          foregroundColor: onDarkColor,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),
          titleTextStyle: TextStyle(
            color: onDarkColor,
          ),
        ),
      ),
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/sprechende_haende.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: AuthStateBuilder(
          loadingBuilder: (_) => const LoadingScreen(),
          errorBuilder: (_, error) => ErrorScreen(error: error),
          unauthenticatedBuilder: (_) => LoginScreen(),
          authenticatedBuilder: (_, user) {
            return FutureBuilder<AppContent>(
              future: GetIt.I<AppService>().load(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done)
                  return const LoadingScreen();

                if (snapshot.hasError)
                  return ErrorScreen(error: snapshot.error!);

                return HomeScreen(appContent: snapshot.data!);
              },
            );
          },
        ),
      ),
    );
  }
}

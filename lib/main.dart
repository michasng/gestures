import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gestures/components/auth_state_builder.dart';
import 'package:gestures/firebase_options.dart';
import 'package:gestures/screens/error/error_screen.dart';
import 'package:gestures/screens/home/home_screen.dart';
import 'package:gestures/screens/loading/loading_screen.dart';
import 'package:gestures/screens/login/login_screen.dart';
import 'package:gestures/services/app_service.dart';
import 'package:gestures/services/search_service.dart';
import 'package:gestures/theme.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  GetIt.I.registerSingleton<AppService>(AppService());
  GetIt.I.registerSingleton<SearchService>(SearchService());

  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ursberger Gebärden',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: AuthStateBuilder(
        loadingBuilder: (_) => const LoadingScreen(),
        errorBuilder: (_, error) => ErrorScreen(error: error),
        unauthenticatedBuilder: (_) => LoginScreen(),
        authenticatedBuilder: (_, __) => HomeScreen(),
      ),
    );
  }
}

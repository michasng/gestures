import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:gestures/firebase_options.dart';
import 'package:gestures/routes/root_route.dart';
import 'package:gestures/services/app_service.dart';
import 'package:gestures/services/permission_service.dart';
import 'package:gestures/services/search_service.dart';
import 'package:gestures/theme.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:micha_core/micha_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  GetIt.I.registerSingleton<PermissionService>(PermissionService());
  GetIt.I.registerSingleton<AppService>(AppService());
  GetIt.I.registerSingleton<SearchService>(SearchService());

  GoogleFonts.config.allowRuntimeFetching = false;
  usePathUrlStrategy();
  initLogging();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      routes: $appRoutes,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ursberger Gebärden',
      debugShowCheckedModeBanner: false,
      theme: theme,
      routerConfig: _router,
    );
  }
}

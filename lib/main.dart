import 'package:flutter/material.dart';
import 'package:gestures/app_router.gr.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // router must not be initialized inside of a build-method
  final appRouter = AppRouter();

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ursberger Gebärden',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}

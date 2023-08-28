import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestures/screens/gesture/gesture_screen.dart';
import 'package:gestures/screens/login/login_screen.dart';
import 'package:gestures/screens/package/package_screen.dart';
import 'package:gestures/screens/packages/packages_screen.dart';
import 'package:gestures/screens/preface/preface_screen.dart';
import 'package:go_router/go_router.dart';

final routerConfig = GoRouter(
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/preface',
      builder: (context, state) => PrefaceScreen(),
    ),
    GoRoute(
      path: '/packages',
      builder: (context, state) => PackagesScreen(),
      routes: [
        GoRoute(
          path: ':packageId',
          builder: (context, state) => PackageScreen(
            packageId: state.pathParameters['packageId'] ?? '',
          ),
          routes: [
            GoRoute(
              path: 'gestures/:gestureId',
              builder: (context, state) => GestureScreen(
                packageId: state.pathParameters['packageId'] ?? '',
                gestureId: state.pathParameters['gestureId'] ?? '',
              ),
            ),
          ],
        ),
      ],
    ),
  ],
  redirect: (context, state) {
    if (FirebaseAuth.instance.currentUser == null) {
      return '/login';
    }
    return null;
  },
);

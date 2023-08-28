import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestures/screens/gesture/gesture_screen.dart';
import 'package:gestures/screens/login/login_screen.dart';
import 'package:gestures/screens/package/package_screen.dart';
import 'package:gestures/screens/packages/packages_screen.dart';
import 'package:gestures/screens/preface/preface_screen.dart';
import 'package:gestures/screens/request_access/request_access_screen.dart';
import 'package:gestures/screens/site_notice/site_notice_screen.dart';
import 'package:go_router/go_router.dart';

String? _redirectUnauthenticated(context, state) {
  if (FirebaseAuth.instance.currentUser == null) {
    return '/login';
  }
  return null;
}

final routerConfig = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        return _redirectUnauthenticated(context, state) ?? '/packages';
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/request_access',
      builder: (context, state) => RequestAccessScreen(),
    ),
    GoRoute(
      path: '/preface',
      builder: (context, state) => PrefaceScreen(),
    ),
    GoRoute(
      path: '/site_notice',
      builder: (context, state) => SiteNoticeScreen(),
    ),
    GoRoute(
      path: '/packages',
      builder: (context, state) => PackagesScreen(),
      redirect: _redirectUnauthenticated,
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
);

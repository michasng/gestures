import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestures/screens/gesture/gesture_screen.dart';
import 'package:gestures/screens/login/login_screen.dart';
import 'package:gestures/screens/package/package_screen.dart';
import 'package:gestures/screens/packages/packages_screen.dart';
import 'package:gestures/screens/preface/preface_screen.dart';
import 'package:gestures/screens/register/register_screen.dart';
import 'package:gestures/screens/search_all/search_all_screen.dart';
import 'package:gestures/screens/settings/settings_screen.dart';
import 'package:gestures/screens/site_notice/site_notice_screen.dart';
import 'package:go_router/go_router.dart';

String? _redirectUnauthenticated(context, state) {
  if (FirebaseAuth.instance.currentUser == null) {
    return LoginScreen.path;
  }
  return null;
}

final routerConfig = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        return _redirectUnauthenticated(context, state) ?? PackagesScreen.path;
      },
    ),
    GoRoute(
      path: LoginScreen.path,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: RegisterScreen.path,
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: PrefaceScreen.path,
      builder: (context, state) => PrefaceScreen(),
    ),
    GoRoute(
      path: SiteNoticeScreen.path,
      builder: (context, state) => SiteNoticeScreen(),
    ),
    GoRoute(
      path: SettingsScreen.path,
      builder: (context, state) => SettingsScreen(),
    ),
    GoRoute(
      path: PackagesScreen.path,
      builder: (context, state) => PackagesScreen(),
      redirect: _redirectUnauthenticated,
      routes: [
        GoRoute(
          path: SearchAllScreen.pathSegment,
          builder: (context, state) => SearchAllScreen(
            searchKey: state.uri.queryParameters['search_key'],
          ),
        ),
        GoRoute(
          path: PackageScreen.pathSegment,
          builder: (context, state) => PackageScreen(
            packageId: state.pathParameters['packageId'] ?? '',
            searchKey: state.uri.queryParameters['search_key'],
          ),
          routes: [
            GoRoute(
              path: GestureScreen.pathSegment,
              builder: (context, state) => GestureScreen(
                packageId: state.pathParameters['packageId'] ?? '',
                gestureId: state.pathParameters['gestureId'] ?? '',
                searchKey: state.uri.queryParameters['search_key'],
                searchingAll:
                    state.uri.queryParameters['searching_all']?.toLowerCase() ==
                        'true',
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

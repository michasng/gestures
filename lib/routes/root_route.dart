import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:gestures/routes/auth/auth_route.dart';
import 'package:gestures/routes/auth/login/login_route.dart';
import 'package:gestures/routes/auth/register/register_route.dart';
import 'package:gestures/routes/auth/reset_password/reset_password_route.dart';
import 'package:gestures/routes/auth/reset_password_sent/reset_password_sent_route.dart';
import 'package:gestures/routes/packages/package/gesture/gesture_route.dart';
import 'package:gestures/routes/packages/package/package_route.dart';
import 'package:gestures/routes/packages/packages_route.dart';
import 'package:gestures/routes/packages/search_all/search_all_route.dart';
import 'package:gestures/routes/preface/preface_route.dart';
import 'package:gestures/routes/settings/settings_route.dart';
import 'package:gestures/routes/site_notice/site_notice_route.dart';
import 'package:go_router/go_router.dart';

part 'root_route.g.dart';

@TypedGoRoute<RootRoute>(
  path: '/',
  routes: [
    TypedGoRoute<AuthRoute>(
      path: 'auth',
      routes: [
        TypedGoRoute<LoginRoute>(path: 'login'),
        TypedGoRoute<RegisterRoute>(path: 'register'),
        TypedGoRoute<ResetPasswordRoute>(path: 'reset-password'),
        TypedGoRoute<ResetPasswordSentRoute>(path: 'reset-password-sent'),
      ],
    ),
    TypedGoRoute<PackagesRoute>(
      path: 'packages',
      routes: [
        TypedGoRoute<SearchAllRoute>(path: 'search-all'),
        TypedGoRoute<PackageRoute>(
          path: ':packageId',
          routes: [TypedGoRoute<GestureRoute>(path: 'gestures/:gestureId')],
        ),
      ],
    ),
    TypedGoRoute<PrefaceRoute>(path: 'preface'),
    TypedGoRoute<SettingsRoute>(path: 'settings'),
    TypedGoRoute<SiteNoticeRoute>(path: 'site-notice'),
  ],
)
class RootRoute extends GoRouteData {
  const RootRoute();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (state.fullPath != location) return null;
    if (FirebaseAuth.instance.currentUser == null) {
      return const LoginRoute().location;
    }
    return const PackagesRoute().location;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Container(); // never visible, will always redirect to child routes
  }
}

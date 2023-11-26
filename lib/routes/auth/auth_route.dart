import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:gestures/routes/auth/login/login_route.dart';
import 'package:gestures/routes/root_route.dart';
import 'package:go_router/go_router.dart';

class AuthRoute extends GoRouteData {
  const AuthRoute();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (state.fullPath != location) return null;
    return const LoginRoute().location;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Container(); // never visible, will always redirect to child routes
  }
}

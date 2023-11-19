import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestures/components/branding/app_background.dart';
import 'package:gestures/components/text/app_title.dart';
import 'package:gestures/routes/auth/login/login_route.dart';
import 'package:gestures/routes/packages/components/async_package_list.dart';
import 'package:gestures/routes/packages/components/main_menu_button.dart';
import 'package:gestures/routes/root_route.dart';
import 'package:go_router/go_router.dart';
import 'package:micha_core/micha_core.dart';

class PackagesRoute extends GoRouteData {
  const PackagesRoute();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (FirebaseAuth.instance.currentUser == null) return LoginRoute().location;
    return null;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AppBackground(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: AppTitle(),
          actions: [
            MainMenuButton(),
            Gap() / 2,
          ],
        ),
        body: AsyncPackageList(),
      ),
    );
  }
}

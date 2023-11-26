import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestures/routes/auth/login/login_route.dart';
import 'package:gestures/routes/packages/packages_route.dart';
import 'package:gestures/routes/root_route.dart';
import 'package:gestures/routes/settings/components/change_password_form.dart';
import 'package:go_router/go_router.dart';

class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const LoginRoute().location;
    }
    return null;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'),
        leading: IconButton(
          onPressed: () => const PackagesRoute().go(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: const SizedBox(
              width: 400,
              child: ChangePasswordForm(),
            ),
          ),
        ],
      ),
      floatingActionButton: FilledButton(
        onPressed: () => const PackagesRoute().go(context),
        child: const Text('Zurück zur App'),
      ),
    );
  }
}

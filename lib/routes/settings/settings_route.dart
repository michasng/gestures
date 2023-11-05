import 'package:flutter/material.dart';
import 'package:gestures/routes/packages/packages_route.dart';
import 'package:gestures/routes/root_route.dart';
import 'package:gestures/routes/settings/components/change_password_form.dart';
import 'package:go_router/go_router.dart';

class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Einstellungen'),
      ),
      body: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: 400,
              child: ChangePasswordForm(),
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          PackagesRoute().go(context);
        },
        child: Text('Zurück zur App'),
      ),
    );
  }
}

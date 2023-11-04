import 'package:flutter/material.dart';
import 'package:gestures/screens/packages/packages_screen.dart';
import 'package:gestures/screens/settings/components/change_password_form.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  static const String path = '/settings';

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          context.go(PackagesScreen.path);
        },
        child: Text('Zurück zur App'),
      ),
    );
  }
}

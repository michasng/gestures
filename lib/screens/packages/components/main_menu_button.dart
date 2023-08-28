import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum MainMenuOption {
  logout;
}

class MainMenuButton extends StatelessWidget {
  const MainMenuButton({super.key});

  void _logout(BuildContext context) async {
    final router = GoRouter.of(context);
    await FirebaseAuth.instance.signOut();
    router.go('/login');
  }

  void _select(BuildContext context, MainMenuOption option) async {
    var handlers = {
      MainMenuOption.logout: _logout,
    };
    handlers[option]?.call(context);
  }

  String _mapOptionLabel(MainMenuOption option) {
    switch (option) {
      case MainMenuOption.logout:
        return 'Abmelden';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          for (var option in MainMenuOption.values)
            PopupMenuItem<MainMenuOption>(
              value: option,
              child: Text(_mapOptionLabel(option)),
            ),
        ];
      },
      onSelected: (option) => _select(context, option),
    );
  }
}

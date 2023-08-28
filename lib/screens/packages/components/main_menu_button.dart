import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum MainMenuOption {
  preface,
  logout,
}

class MainMenuButton extends StatelessWidget {
  const MainMenuButton({super.key});

  void _selectPreface(BuildContext context) async {
    context.go('/preface');
  }

  void _selectLogout(BuildContext context) async {
    final router = GoRouter.of(context);
    await FirebaseAuth.instance.signOut();
    router.go('/login');
  }

  void _select(BuildContext context, MainMenuOption option) async {
    switch (option) {
      case MainMenuOption.preface:
        return _selectPreface(context);
      case MainMenuOption.logout:
        return _selectLogout(context);
    }
  }

  String _mapOptionLabel(MainMenuOption option) {
    switch (option) {
      case MainMenuOption.preface:
        return 'Vorwort';
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

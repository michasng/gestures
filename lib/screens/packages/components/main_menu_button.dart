import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum MainMenuOption {
  preface,
  siteNotice,
  logout,
}

class MainMenuButton extends StatelessWidget {
  const MainMenuButton({super.key});

  void _select(BuildContext context, MainMenuOption option) async {
    final router = GoRouter.of(context);

    switch (option) {
      case MainMenuOption.preface:
        return router.go('/preface');
      case MainMenuOption.siteNotice:
        return router.go('/site_notice');
      case MainMenuOption.logout:
        await FirebaseAuth.instance.signOut();
        return router.go('/login');
    }
  }

  String _mapOptionLabel(MainMenuOption option) {
    switch (option) {
      case MainMenuOption.preface:
        return 'Vorwort';
      case MainMenuOption.siteNotice:
        return 'Impressum';
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

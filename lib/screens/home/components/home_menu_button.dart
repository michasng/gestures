import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum HomeMenuOption {
  logout;
}

class HomeMenuButton extends StatelessWidget {
  const HomeMenuButton({super.key});

  void _logout() async {
    await FirebaseAuth.instance.signOut();
  }

  void _select(HomeMenuOption option) async {
    var handlers = {
      HomeMenuOption.logout: _logout,
    };
    handlers[option]?.call();
  }

  String _mapOptionLabel(HomeMenuOption option) {
    switch (option) {
      case HomeMenuOption.logout:
        return 'Abmelden';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          for (var option in HomeMenuOption.values)
            PopupMenuItem<HomeMenuOption>(
              value: option,
              child: Text(_mapOptionLabel(option)),
            ),
        ];
      },
      onSelected: _select,
    );
  }
}

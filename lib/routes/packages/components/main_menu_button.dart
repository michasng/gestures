import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestures/components/text/links/privacy_policy_link.dart';
import 'package:gestures/routes/auth/login/login_route.dart';
import 'package:gestures/routes/preface/preface_route.dart';
import 'package:gestures/routes/root_route.dart';
import 'package:gestures/routes/settings/settings_route.dart';
import 'package:gestures/routes/site_notice/site_notice_route.dart';
import 'package:gestures/services/app_service.dart';
import 'package:gestures/services/permission_service.dart';
import 'package:get_it/get_it.dart';

enum MainMenuOption {
  preface,
  siteNotice,
  privacyPolicy,
  settings,
  exportAppContent(true),
  logout;

  final bool accessRestricted;

  const MainMenuOption([this.accessRestricted = false]);
}

class MainMenuButton extends StatelessWidget {
  const MainMenuButton({super.key});

  void _select(BuildContext context, MainMenuOption option) async {
    switch (option) {
      case MainMenuOption.preface:
        if (!context.mounted) return;
        return PrefaceRoute().go(context);
      case MainMenuOption.siteNotice:
        if (!context.mounted) return;
        return SiteNoticeRoute().go(context);
      case MainMenuOption.privacyPolicy:
        return await PrivacyPolicyLink.showPrivacyPolicy();
      case MainMenuOption.settings:
        if (!context.mounted) return;
        return SettingsRoute().go(context);
      case MainMenuOption.exportAppContent:
        return await GetIt.I<AppService>().exportLiveAppContent(context);
      case MainMenuOption.logout:
        await FirebaseAuth.instance.signOut();
        if (!context.mounted) return;
        return LoginRoute().go(context);
    }
  }

  String _mapOptionLabel(MainMenuOption option) {
    switch (option) {
      case MainMenuOption.preface:
        return 'Vorwort';
      case MainMenuOption.siteNotice:
        return 'Impressum';
      case MainMenuOption.privacyPolicy:
        return 'Datenschutzerklärung';
      case MainMenuOption.settings:
        return 'Einstellungen';
      case MainMenuOption.exportAppContent:
        return 'JSON exportieren';
      case MainMenuOption.logout:
        return 'Abmelden';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPrivilegedUser = GetIt.I<PermissionService>().isPrivilegedUser();

    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          for (var option in MainMenuOption.values)
            if (!option.accessRestricted || isPrivilegedUser)
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

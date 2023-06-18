import 'package:flutter/material.dart';
import 'package:gestures/components/app_title.dart';
import 'package:gestures/models/app_content.dart';
import 'package:gestures/models/package.dart';
import 'package:gestures/screens/home/components/home_menu_button.dart';
import 'package:gestures/screens/home/components/package_list_tile.dart';

class HomeScreen extends StatelessWidget {
  final AppContent appContent;

  const HomeScreen({super.key, required this.appContent});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final allGestures = [...appContent.packages.expand((p) => p.gestures)];
    allGestures.sort((g1, g2) => g1.title.compareTo(g2.title));

    return Scaffold(
      appBar: AppBar(
        title: AppTitle(),
        actions: [
          HomeMenuButton(),
          SizedBox(width: 8),
        ],
      ),
      body: ListView(
        children: [
          PackageListTile(
            package: Package(
              title: 'Alle Gebärden durchsuchen',
              gestures: allGestures,
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Pakete',
              style: theme.textTheme.headlineSmall
                  ?.copyWith(color: theme.colorScheme.onPrimary),
            ),
          ),
          for (final package in appContent.packages)
            PackageListTile(package: package),
        ],
      ),
    );
  }
}

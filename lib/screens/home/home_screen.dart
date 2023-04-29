import 'package:flutter/material.dart';
import 'package:gestures/models/app_content.dart';
import 'package:gestures/models/package.dart';
import 'package:gestures/screens/home/components/package_list_tile.dart';
import 'package:gestures/screens/package/components/logo.dart';
import 'package:google_fonts/google_fonts.dart';

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
        centerTitle: true,
        toolbarHeight: 64,
        leading: Logo(withText: false, color: theme.colorScheme.onPrimary),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
        title: Text(
          'Ursberger Gebärden',
          style: GoogleFonts.cinzelDecorative(
            textStyle: theme.textTheme.headlineSmall,
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
      body: ListView(
        children: [
          PackageListTile(
            package: Package(
              title: 'Alle Gebärden',
              gestures: allGestures,
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Pakete',
              style: theme.textTheme.headlineSmall
                  ?.copyWith(color: theme.colorScheme.onBackground),
            ),
          ),
          for (final package in appContent.packages)
            PackageListTile(package: package),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Logo(withText: true, color: theme.colorScheme.onBackground),
          ),
        ],
      ),
    );
  }
}

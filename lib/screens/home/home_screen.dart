import 'package:flutter/material.dart';
import 'package:gestures/models/app_content.dart';
import 'package:gestures/models/package.dart';
import 'package:gestures/screens/home/components/package_list_tile.dart';

class HomeScreen extends StatelessWidget {
  final AppContent appContent;

  const HomeScreen({Key? key, required this.appContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allGestures = [...appContent.packages.expand((p) => p.gestures)];
    allGestures.sort((g1, g2) => g1.title.compareTo(g2.title));
    final combinedPackage = Package(
      title: 'Alle',
      gestures: allGestures,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Ursberger Gebärden - Paket wählen')),
      body: ListView(
        children: [
          PackageListTile(package: combinedPackage),
          for (final package in appContent.packages)
            PackageListTile(package: package),
        ],
      ),
    );
  }
}

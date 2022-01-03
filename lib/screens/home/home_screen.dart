import 'package:flutter/material.dart';
import 'package:gestures/models/app_content.dart';
import 'package:gestures/screens/home/components/package_list_tile.dart';

class HomeScreen extends StatelessWidget {
  final AppContent appContent;

  const HomeScreen({Key? key, required this.appContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paket wählen')),
      body: ListView(
        children: [
          for (final package in appContent.packages)
            PackageListTile(package: package),
        ],
      ),
    );
  }
}

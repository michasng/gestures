import 'package:flutter/material.dart';
import 'package:gestures/models/package.dart';
import 'package:gestures/screens/package/components/gesture_list_tile.dart';

class PackageScreen extends StatelessWidget {
  final Package package;

  const PackageScreen({Key? key, required this.package}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gebärde wählen')),
      body: ListView(
        children: [
          for (final gesture in package.gestures)
            GestureListTile(gesture: gesture),
        ],
      ),
    );
  }
}

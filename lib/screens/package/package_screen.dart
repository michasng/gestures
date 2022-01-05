import 'package:flutter/material.dart';
import 'package:gestures/models/gesture.dart';
import 'package:gestures/models/package.dart';
import 'package:gestures/screens/gesture/gesture_screen.dart';
import 'package:gestures/screens/package/components/gesture_list_tile.dart';

class PackageScreen extends StatelessWidget {
  final Package package;

  const PackageScreen({Key? key, required this.package}) : super(key: key);

  void _navigateToGesture(BuildContext context, Gesture gesture) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GestureScreen(
          gestures: package.gestures,
          initialIndex: package.gestures.indexOf(gesture),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gebärde wählen')),
      body: ListView(
        children: [
          for (final gesture in package.gestures)
            GestureListTile(
              gesture: gesture,
              onTap: (gesture) => _navigateToGesture(context, gesture),
            ),
        ],
      ),
    );
  }
}

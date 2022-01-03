import 'package:flutter/material.dart';
import 'package:gestures/models/gesture.dart';
import 'package:gestures/screens/gesture/gesture_screen.dart';

class GestureListTile extends StatelessWidget {
  final Gesture gesture;

  const GestureListTile({Key? key, required this.gesture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(gesture.title),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => GestureScreen(gesture: gesture),
        ),
      ),
    );
  }
}

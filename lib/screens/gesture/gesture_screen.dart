import 'package:flutter/material.dart';
import 'package:gestures/models/gesture.dart';
import 'package:gestures/screens/gesture/components/gesture_player.dart';

class GestureScreen extends StatelessWidget {
  final Gesture gesture;

  const GestureScreen({Key? key, required this.gesture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gebärde')),
      body: GesturePlayer(gesture: gesture),
    );
  }
}

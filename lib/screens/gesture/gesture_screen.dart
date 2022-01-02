import 'package:flutter/material.dart';
import 'package:gestures/screens/gesture/components/gesture_player.dart';

class GestureScreen extends StatelessWidget {
  const GestureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gebärde')),
      body: const GesturePlayer(),
    );
  }
}

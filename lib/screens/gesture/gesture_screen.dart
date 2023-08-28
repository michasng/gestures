import 'package:flutter/material.dart';
import 'package:gestures/screens/gesture/components/async_gesture_view.dart';

class GestureScreen extends StatelessWidget {
  final String packageId;
  final String gestureId;

  const GestureScreen({
    super.key,
    required this.packageId,
    required this.gestureId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: FittedBox(child: Text(gestureId))),
      body: AsyncGestureView(
        key: ValueKey('$packageId, $gestureId'),
        packageId: packageId,
        gestureId: gestureId,
      ),
    );
  }
}

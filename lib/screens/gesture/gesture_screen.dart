import 'package:flutter/material.dart';
import 'package:gestures/screens/gesture/components/async_gesture_view.dart';
import 'package:gestures/screens/package/package_screen.dart';

class GestureScreen extends StatelessWidget {
  static const String pathSegment = 'gestures/:gestureId';
  static String path({
    required String packageId,
    required String gestureId,
  }) {
    final packagePath = PackageScreen.path(packageId: packageId);
    return '$packagePath/gestures/$gestureId';
  }

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

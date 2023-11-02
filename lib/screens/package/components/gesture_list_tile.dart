import 'package:flutter/material.dart';
import 'package:gestures/models/gesture.dart';

class GestureListTile extends StatelessWidget {
  final Gesture gesture;
  final void Function(Gesture gesture) onTap;
  final bool showPackageTitle;

  const GestureListTile({
    super.key,
    required this.gesture,
    required this.onTap,
    required this.showPackageTitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(gesture.title),
      subtitle: showPackageTitle ? Text(gesture.packageId) : null,
      onTap: () => onTap(gesture),
    );
  }
}

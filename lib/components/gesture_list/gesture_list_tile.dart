import 'package:flutter/material.dart';
import 'package:gestures/models/distinct_gesture.dart';

class GestureListTile extends StatelessWidget {
  final DistinctGesture gesture;
  final void Function(DistinctGesture gesture) onTap;
  final Widget? subtitle;

  const GestureListTile({
    super.key,
    required this.gesture,
    required this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(gesture.title),
      subtitle: subtitle,
      onTap: () => onTap(gesture),
    );
  }
}

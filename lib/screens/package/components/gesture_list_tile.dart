import 'package:flutter/material.dart';
import 'package:gestures/models/distinct_gesture.dart';

class GestureListTile extends StatelessWidget {
  final DistinctGesture gesture;
  final void Function(DistinctGesture gesture) onTap;
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
      subtitle: showPackageTitle ? Text(gesture.package.title) : null,
      onTap: () => onTap(gesture),
    );
  }
}

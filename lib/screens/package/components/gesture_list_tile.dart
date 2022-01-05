import 'package:flutter/material.dart';
import 'package:gestures/models/gesture.dart';

class GestureListTile extends StatelessWidget {
  final Gesture gesture;
  final void Function(Gesture gesture) onTap;

  const GestureListTile({
    Key? key,
    required this.gesture,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(gesture.title),
      onTap: () => onTap(gesture),
    );
  }
}

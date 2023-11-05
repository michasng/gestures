import 'package:flutter/material.dart';
import 'package:gestures/models/distinct_gesture.dart';
import 'package:gestures/screens/package/components/gesture_list_tile.dart';

class GestureList extends StatelessWidget {
  final List<DistinctGesture> gestures;
  final bool showPackageTitles;
  final void Function(DistinctGesture gesture) onTapGesture;

  const GestureList({
    super.key,
    required this.gestures,
    required this.showPackageTitles,
    required this.onTapGesture,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final gesture in gestures)
          GestureListTile(
            gesture: gesture,
            onTap: onTapGesture,
            subtitle: showPackageTitles ? Text(gesture.package.title) : null,
          ),
      ],
    );
  }
}

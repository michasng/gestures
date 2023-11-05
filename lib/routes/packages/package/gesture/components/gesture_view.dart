import 'package:flutter/material.dart';
import 'package:gestures/components/aspect_ratio_builder.dart';
import 'package:gestures/models/distinct_gesture.dart';
import 'package:gestures/routes/packages/package/gesture/components/gesture_player.dart';

class GestureView extends StatelessWidget {
  final DistinctGesture gesture;
  final Widget controlsChild;

  const GestureView({
    super.key,
    required this.gesture,
    required this.controlsChild,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatioBuilder(
      minHeightSurplusForPortrait: 100,
      minWidthSurplusForLandscape: 300,
      builder: (context, mode) {
        final playerChild = GesturePlayer(
          gesture: gesture,
          // use gesture as a key to rebuild the player whenever the gesture changes
          key: ValueKey(gesture),
        );

        if (mode == AspectRatioMode.portrait) {
          return Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: playerChild,
              ),
              Expanded(
                child: controlsChild,
              ),
            ],
          );
        }

        if (mode == AspectRatioMode.landscape) {
          return Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: playerChild,
              ),
              Expanded(
                child: controlsChild,
              ),
            ],
          );
        }

        return Column(
          children: [
            Expanded(
              child: playerChild,
            ),
            Expanded(
              child: controlsChild,
            ),
          ],
        );
      },
    );
  }
}

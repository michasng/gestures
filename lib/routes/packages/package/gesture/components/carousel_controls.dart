import 'package:flutter/material.dart';
import 'package:gestures/models/distinct_gesture.dart';
import 'package:micha_core/micha_core.dart';

class CarouselControls extends StatelessWidget {
  final DistinctGesture gesture;
  final void Function() onPrevious;
  final void Function() onNext;

  const CarouselControls({
    super.key,
    required this.gesture,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onPrevious,
          icon: const Icon(Icons.skip_previous_rounded),
          iconSize: 32,
          disabledColor: Colors.transparent,
        ),
        Flexible(
          child: FittedBox(
            child: ThemedText.headlineSmall(gesture.title),
          ),
        ),
        IconButton(
          onPressed: onNext,
          icon: const Icon(Icons.skip_next_rounded),
          iconSize: 32,
          disabledColor: Colors.transparent,
        ),
      ],
    );
  }
}

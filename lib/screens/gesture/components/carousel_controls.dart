import 'package:flutter/material.dart';
import 'package:gestures/components/text/headline_small.dart';
import 'package:gestures/models/gesture.dart';

class CarouselControls extends StatelessWidget {
  final Gesture gesture;
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
            child: HeadlineSmall(gesture.title),
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

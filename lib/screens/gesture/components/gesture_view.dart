import 'package:flutter/material.dart';
import 'package:gestures/models/gesture.dart';
import 'package:gestures/screens/gesture/components/gesture_player.dart';

class GestureView extends StatelessWidget {
  final Gesture gesture;
  final void Function()? onPrevious;
  final void Function()? onNext;

  const GestureView({
    super.key,
    required this.gesture,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          // use gesture as a key to rebuild the player whenever the gesture changes
          child: GesturePlayer(
            gesture: gesture,
            key: ValueKey(gesture),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              IconButton(
                onPressed: onPrevious,
                icon: const Icon(Icons.skip_previous_rounded),
                iconSize: 32,
                disabledColor: Colors.transparent,
              ),
              const Spacer(),
              Text(
                gesture.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Spacer(),
              IconButton(
                onPressed: onNext,
                icon: const Icon(Icons.skip_next_rounded),
                iconSize: 32,
                disabledColor: Colors.transparent,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

enum AspectRatioMode {
  portrait,
  landscape,
  squarish;
}

typedef AspectRatioBuilderCallback = Widget Function(
  BuildContext context,
  AspectRatioMode mode,
);

class AspectRatioBuilder extends StatelessWidget {
  final AspectRatioBuilderCallback builder;
  final int minHeightSurplusForPortrait;
  final int minWidthSurplusForLandscape;

  const AspectRatioBuilder({
    super.key,
    required this.builder,
    this.minHeightSurplusForPortrait = 0,
    this.minWidthSurplusForLandscape = 0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final difference = constraints.maxHeight - constraints.maxWidth;

        if (difference >= minHeightSurplusForPortrait)
          return builder(context, AspectRatioMode.portrait);
        if (-difference >= minWidthSurplusForLandscape)
          return builder(context, AspectRatioMode.landscape);
        return builder(context, AspectRatioMode.squarish);
      },
    );
  }
}

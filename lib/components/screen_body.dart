import 'package:flutter/material.dart';
import 'package:micha_core/micha_core.dart';

class ScreenBody extends StatelessWidget {
  final Alignment alignment;
  final List<Widget> children;

  const ScreenBody({
    super.key,
    this.alignment = Alignment.topCenter,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        alignment: alignment,
        child: SingleChildScrollView(
          child: SelectionArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...children,
                const Gap() * 4,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

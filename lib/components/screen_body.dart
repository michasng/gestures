import 'package:flutter/material.dart';

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
      padding: EdgeInsets.all(16),
      child: Container(
        alignment: alignment,
        child: SingleChildScrollView(
          child: SelectionArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...children,
                SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  final int size;

  const Spinner({
    super.key,
    this.size = 256,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size.toDouble(),
        height: size.toDouble(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}

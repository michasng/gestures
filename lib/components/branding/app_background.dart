import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/sprechende_haende.png'),
          fit: BoxFit.fitHeight,
          repeat: ImageRepeat.repeatX,
        ),
      ),
      child: child,
    );
  }
}

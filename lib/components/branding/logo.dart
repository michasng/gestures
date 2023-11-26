import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double? height;

  const Logo({
    super.key,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: height,
      alignment: Alignment.bottomRight,
      child: const Image(
        image: AssetImage('assets/logo.png'),
        filterQuality: FilterQuality.medium,
      ),
    );
  }
}

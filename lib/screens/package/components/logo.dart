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
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Image(
              image: AssetImage('assets/logo.png'),
              filterQuality: FilterQuality.medium,
              color: Color(0xffa60430),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

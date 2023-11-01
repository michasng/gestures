import 'package:flutter/material.dart';

class LinkText extends StatelessWidget {
  final String data;
  final VoidCallback? onTap;

  const LinkText(
    this.data, {
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        data,
        style: onTap == null
            ? null
            : TextStyle(
                color: Color(0xff0086BB),
              ),
      ),
    );
  }
}

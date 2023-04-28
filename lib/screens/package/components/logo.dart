import 'package:flutter/widgets.dart';

class Logo extends StatelessWidget {
  final bool withText;
  final Color? color;

  const Logo({
    super.key,
    required this.withText,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final fileName = withText ? 'logo_with_text.png' : 'logo.png';

    return Image(
      image: AssetImage('assets/$fileName'),
      filterQuality: FilterQuality.medium,
      color: color,
    );
  }
}

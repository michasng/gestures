import 'package:flutter/material.dart';

class HeadlineSmall extends StatelessWidget {
  final String data;

  const HeadlineSmall(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      data,
      style: theme.textTheme.headlineSmall,
    );
  }
}

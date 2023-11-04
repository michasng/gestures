import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String data;

  const ErrorText(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      data,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.error,
      ),
    );
  }
}

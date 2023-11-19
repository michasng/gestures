import 'package:flutter/material.dart';
import 'package:micha_core/micha_core.dart';

class ErrorText extends StatelessWidget {
  final String data;

  const ErrorText(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ThemedText.bodyMedium(
      data,
      options: TextOptions(
        style: TextStyle(color: theme.colorScheme.error),
      ),
    );
  }
}

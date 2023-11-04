import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FittedBox(
      child: Text(
        'Ursberger Gebärden',
        style: theme.textTheme.headlineSmall?.copyWith(
          color: theme.appBarTheme.titleTextStyle?.color,
        ),
      ),
    );
  }
}

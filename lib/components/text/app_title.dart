import 'package:flutter/material.dart';
import 'package:micha_core/micha_core.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FittedBox(
      child: ThemedText.headlineSmall(
        'Ursberger Gebärden',
        options: TextOptions(
          style: TextStyle(
            color: theme.appBarTheme.titleTextStyle?.color,
          ),
        ),
      ),
    );
  }
}

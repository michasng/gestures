import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        style: GoogleFonts.cinzelDecorative(
          textStyle: theme.textTheme.headlineSmall,
          color: theme.appBarTheme.titleTextStyle?.color,
        ),
      ),
    );
  }
}

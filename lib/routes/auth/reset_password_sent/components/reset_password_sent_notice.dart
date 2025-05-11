import 'package:flutter/material.dart';
import 'package:gestures/routes/auth/login/login_route.dart';
import 'package:gestures/routes/root_route.dart';
import 'package:micha_core/micha_core.dart';

class ResetPasswordSentNotice extends StatelessWidget {
  const ResetPasswordSentNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        const ThemedText.headlineSmall('E-Mail gesendet'),
        Text(
          'Wir haben einen Link zum Zurücksetzen Ihres Passworts an Ihr E-Mail-Postfach gesendet.',
          textAlign: TextAlign.justify,
        ),
        Text(
          'Bitte haben Sie etwas Geduld und prüfen Sie auch Ihren Spam-Ordner.',
          textAlign: TextAlign.justify,
        ),
        OutlinedButton(
          onPressed: () => LoginRoute().go(context),
          child: const Text('Zur Anmeldung'),
        ),
      ],
    );
  }
}

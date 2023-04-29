import 'package:flutter/material.dart';
import 'package:gestures/screens/login/components/login_form.dart';
import 'package:gestures/screens/package/components/logo.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 64,
        leading: Logo(withText: false, color: theme.colorScheme.onBackground),
        backgroundColor: Colors.transparent,
        foregroundColor: theme.colorScheme.onBackground,
        elevation: 0,
        title: Text(
          'Ursberger Gebärden',
          style: GoogleFonts.cinzelDecorative(
            textStyle: theme.textTheme.headlineSmall,
            color: theme.colorScheme.onBackground,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 256,
          child: LoginForm(),
        ),
      ),
    );
  }
}

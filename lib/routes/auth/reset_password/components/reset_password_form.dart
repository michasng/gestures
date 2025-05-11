import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestures/components/text/error_text.dart';
import 'package:gestures/firebase_auth_error.dart';
import 'package:gestures/routes/auth/login/login_route.dart';
import 'package:gestures/routes/auth/reset_password_sent/reset_password_sent_route.dart';
import 'package:gestures/routes/root_route.dart';
import 'package:micha_core/micha_core.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;
  String? _errorMessage;

  String? _email;

  Future<void> _submit() async {
    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });
    await _submitInternal();
    setState(() => _isSubmitting = false);
  }

  Future<void> _submitInternal() async {
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) return;
    formState.save();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email!.trim());
      if (mounted) {
        const ResetPasswordSentRoute().go(context);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = FirebaseAuthError.byCode(e.code)?.message ?? e.code;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          const ThemedText.headlineSmall('Passwort zurücksetzen'),
          Text(
            'Wir senden einen Link zum Zurücksetzen Ihres Passworts an Ihr E-Mail-Postfach.',
            textAlign: TextAlign.justify,
          ),
          TextFormField(
            autofillHints: const [AutofillHints.email],
            onFieldSubmitted: _isSubmitting ? null : (_) => _submit(),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Bitte E-Mail Adresse eingeben.';
              }
              return null;
            },
            onSaved: (value) => _email = value,
            decoration: const InputDecoration(labelText: 'E-Mail Adresse'),
          ),
          if (_errorMessage != null)
            Row(children: [const Spacer(), ErrorText(_errorMessage!)]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 16,
            children: [
              Link(
                onTap: () {
                  const LoginRoute().go(context);
                },
                child: const Text('Mit Passwort anmelden'),
              ),
              if (_isSubmitting)
                const Spinner(size: 24)
              else
                FilledButton(
                  onPressed: _submit,
                  child: const Text('Bestätigen'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestures/components/form_fields/secret_text_form_field.dart';
import 'package:gestures/components/text/error_text.dart';
import 'package:gestures/components/text/links/privacy_policy_link.dart';
import 'package:gestures/components/text/links/site_notice_link.dart';
import 'package:gestures/firebase_auth_error.dart';
import 'package:gestures/routes/auth/login/login_route.dart';
import 'package:gestures/routes/preface/preface_route.dart';
import 'package:gestures/routes/root_route.dart';
import 'package:micha_core/micha_core.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;
  String? _errorMessage;

  final _passwordController = TextEditingController();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  String? _email;
  String? _password;

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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email!.trim(),
        password: _password!.trim(),
      );
      if (mounted) const PrefaceRoute().go(context);
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
          const ThemedText.headlineSmall('Registrieren'),
          TextFormField(
            autofillHints: const [AutofillHints.email],
            onFieldSubmitted: (_) => _passwordFocus.requestFocus(),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Bitte E-Mail Adresse eingeben.';
              }
              return null;
            },
            onSaved: (value) => _email = value,
            decoration: const InputDecoration(labelText: 'E-Mail Adresse'),
          ),
          SecretTextFormField(
            controller: _passwordController,
            focusNode: _passwordFocus,
            autofillHints: const [AutofillHints.newPassword],
            onFieldSubmitted: (_) => _confirmPasswordFocus.requestFocus(),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Bitte Passwort eingeben.';
              return null;
            },
            onSaved: (value) => _password = value,
            decoration: const InputDecoration(labelText: 'Passwort'),
          ),
          SecretTextFormField(
            focusNode: _confirmPasswordFocus,
            onFieldSubmitted: _isSubmitting ? null : (_) => _submit(),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Bitte Passwort eingeben.';
              if (value?.trim() != _passwordController.text.trim()) {
                return 'Die Passwörter unterscheiden sich.';
              }
              return null;
            },
            decoration: const InputDecoration(labelText: 'Passwort bestätigen'),
          ),
          if (_errorMessage != null)
            Row(children: [const Spacer(), ErrorText(_errorMessage!)]),
          const Row(
            spacing: 16,
            children: [PrivacyPolicyLink(), SiteNoticeLink()],
          ),
          Row(
            children: [
              Link(
                onTap: () {
                  const LoginRoute().go(context);
                },
                child: const Text('Bereits registriert?'),
              ),
              const Spacer(),
              if (_isSubmitting) ...[const Gap(), const Spinner(size: 24)],
              const Gap(),
              FilledButton(
                onPressed: _isSubmitting ? null : _submit,
                child: const Text('Bestätigen'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestures/components/links/link_text.dart';
import 'package:gestures/components/links/privacy_policy_link.dart';
import 'package:gestures/components/links/site_notice_link.dart';
import 'package:gestures/components/secret_text_form_field.dart';
import 'package:gestures/screens/login/login_screen.dart';
import 'package:gestures/screens/preface/preface_screen.dart';
import 'package:go_router/go_router.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  String? _email;
  String? _password;
  String? _errorMessage;

  String _errorCodeToMessage(String? code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Dieser Nutzer existiert bereits.';
      case 'invalid-email':
        return 'Die E-Mail Adresse ist ungültig.';
      case 'operation-not-allowed':
        return 'Der Vorgang ist aus technischen Gründen nicht erlaubt.';
      case 'weak-password':
        return 'Bitte wählen Sie ein stärkeres Passwort.';
      case null:
        return 'Unbekannter Fehler';
      default:
        return 'Unerwarteter Fehler: $code';
    }
  }

  void _submit() async {
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) return;
    formState.save();

    final router = GoRouter.of(context);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email!.trim(),
        password: _password!.trim(),
      );
      router.go(PrefaceScreen.path);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = _errorCodeToMessage(e.code);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Registrieren',
            style: theme.textTheme.headlineSmall,
          ),
          SizedBox(height: 16),
          TextFormField(
            autofillHints: [AutofillHints.email],
            onFieldSubmitted: (_) => _passwordFocus.requestFocus(),
            validator: (value) {
              if (value?.isEmpty ?? true)
                return 'Bitte E-Mail Adresse eingeben.';
              return null;
            },
            onSaved: (value) => _email = value,
            decoration: const InputDecoration(
              labelText: 'E-Mail Adresse',
            ),
          ),
          SizedBox(height: 16),
          SecretTextFormField(
            controller: _passwordController,
            focusNode: _passwordFocus,
            autofillHints: [AutofillHints.password],
            onFieldSubmitted: (_) => _confirmPasswordFocus.requestFocus(),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Bitte Passwort eingeben.';
              return null;
            },
            onSaved: (value) => _password = value,
            decoration: InputDecoration(
              labelText: 'Passwort',
            ),
          ),
          SizedBox(height: 16),
          SecretTextFormField(
            focusNode: _confirmPasswordFocus,
            onFieldSubmitted: (_) => _submit(),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Bitte Passwort eingeben.';
              if (value?.trim() != _passwordController.text.trim())
                return 'Die Passwörter unterscheiden sich.';
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Passwort bestätigen',
            ),
          ),
          if (_errorMessage != null) ...[
            SizedBox(height: 16),
            Row(
              children: [
                Spacer(),
                Text(
                  _errorMessage!,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.error),
                ),
              ],
            ),
          ],
          SizedBox(height: 16),
          Row(
            children: [
              PrivacyPolicyLink(),
              SizedBox(width: 16),
              SiteNoticeLink(),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LinkText(
                'Bereits registriert?',
                onTap: () {
                  context.go(LoginScreen.path);
                },
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Bestätigen'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

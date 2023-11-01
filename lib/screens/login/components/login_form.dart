import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestures/components/links/link_text.dart';
import 'package:gestures/components/links/privacy_policy_link.dart';
import 'package:gestures/components/links/site_notice_link.dart';
import 'package:gestures/components/secret_text_form_field.dart';
import 'package:gestures/screens/preface/preface_screen.dart';
import 'package:gestures/screens/register/register_screen.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFocus = FocusNode();
  String? _email;
  String? _password;
  String? _errorMessage;

  String _errorCodeToMessage(String? code) {
    switch (code) {
      case 'invalid-email':
        return 'Die E-Mail Adresse ist ungültig.';
      case 'user-disabled':
        return 'Dieser Nutzer ist deaktiviert.';
      case 'user-not-found':
        return 'Dieser Nutzer existiert nicht.';
      case 'wrong-password':
        return 'Das Passwort ist falsch.';
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
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
            'Anmelden',
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
            focusNode: _passwordFocus,
            autofillHints: [AutofillHints.password],
            onFieldSubmitted: (_) => _submit(),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Bitte Passwort eingeben.';
              return null;
            },
            onSaved: (value) => _password = value,
            decoration: InputDecoration(
              labelText: 'Passwort',
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
                'Neues Konto erstellen',
                onTap: () {
                  context.go(RegisterScreen.path);
                },
              ),
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

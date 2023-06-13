import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  bool _obscurePassword = true;

  // workaround for https://github.com/firebase/flutterfire/issues/10966
  String? extractFirebaseAuthExceptionCode(FirebaseAuthException exception) {
    if (exception.code != 'unknown') return exception.code;
    if (exception.message == null) return null;

    String regexPattern = r'(?<=\(auth/)(.*?)(?=\)\.)';
    RegExp regExp = RegExp(regexPattern);
    Match? match = regExp.firstMatch(exception.message!);

    return match == null ? null : match.group(0)!;
  }

  String _errorCodeToMessage(String? code) {
    switch (code) {
      case 'invalid-email':
        return 'Die E-Mail Adresse ist ungültig.';
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
    var formState = _formKey.currentState;
    if (formState?.validate() ?? false) {
      formState!.save();
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email!.trim(),
          password: _password!.trim(),
        );
      } on FirebaseAuthException catch (e) {
        final code = extractFirebaseAuthExceptionCode(e);
        setState(() {
          _errorMessage = _errorCodeToMessage(code);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                return 'Bitte E-Mail Adresse eingeben';
              return null;
            },
            onSaved: (value) => _email = value,
            decoration: const InputDecoration(
              labelText: 'E-Mail Adresse',
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            focusNode: _passwordFocus,
            obscureText: _obscurePassword,
            autofillHints: [AutofillHints.password],
            onFieldSubmitted: (_) => _submit(),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Bitte Passwort eingeben';
              return null;
            },
            onSaved: (value) => _password = value,
            decoration: InputDecoration(
              labelText: 'Passwort',
              suffixIcon: IconButton(
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('TODO: Account-Anfrage abschicken'),
                    ),
                  );
                },
                child: Text('Account anfragen'),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Bestätigen'),
              ),
            ],
          ),
          SizedBox(height: 16),
          if (_errorMessage != null)
            Row(
              children: [
                Spacer(),
                Text(
                  _errorMessage!,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.error),
                ),
              ],
            )
        ],
      ),
    );
  }
}

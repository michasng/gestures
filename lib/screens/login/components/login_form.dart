import 'package:flutter/material.dart';
import 'package:gestures/models/credentials.dart';

class LoginForm extends StatefulWidget {
  final void Function(Credentials credentials) onLogin;

  const LoginForm({
    super.key,
    required this.onLogin,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  String? _email;
  String? _password;

  void _submit() {
    var formState = _formKey.currentState;
    if (formState?.validate() ?? false) {
      formState!.save();
      widget.onLogin(
        Credentials(
          email: _email!,
          password: _password!,
        ),
      );
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
            focusNode: _emailFocus,
            autofocus: true,
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
            onFieldSubmitted: (_) => _submit(),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Bitte Passwort eingeben';
              return null;
            },
            onSaved: (value) => _password = value,
            decoration: const InputDecoration(
              labelText: 'Passwort',
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
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestures/components/form_fields/secret_text_form_field.dart';
import 'package:gestures/components/text/error_text.dart';
import 'package:gestures/components/text/headline_small.dart';
import 'package:gestures/firebase_auth_error.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordFocus = FocusNode();
  final _confirmNewPasswordFocus = FocusNode();
  final _oldPasswordFocus = FocusNode();
  String? _newPassword;
  String? _oldPassword;
  String? _errorMessage;

  void _submit() async {
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) return;
    formState.save();

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null ||
          user.email == null ||
          _oldPassword == null ||
          _newPassword == null) {
        _errorMessage = 'Ein unterwarteter Fehler ist aufgetreten.';
        return;
      }

      await user.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: user.email!,
          password: _oldPassword!,
        ),
      );
      await user.updatePassword(_newPassword!);
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Passwort wurde geändert.')),
      );
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
        children: [
          HeadlineSmall('Passwort ändern'),
          SizedBox(height: 16),
          SecretTextFormField(
            controller: _passwordController,
            focusNode: _passwordFocus,
            autofillHints: [AutofillHints.newPassword],
            onFieldSubmitted: (_) => _confirmNewPasswordFocus.requestFocus(),
            validator: (value) {
              if (value?.isEmpty ?? true)
                return 'Bitte neues Passwort eingeben.';
              return null;
            },
            onSaved: (value) => _newPassword = value,
            decoration: InputDecoration(
              labelText: 'neues Passwort',
            ),
          ),
          SizedBox(height: 16),
          SecretTextFormField(
            focusNode: _confirmNewPasswordFocus,
            onFieldSubmitted: (_) => _oldPasswordFocus.requestFocus(),
            validator: (value) {
              if (value?.isEmpty ?? true)
                return 'Bitte neues Passwort eingeben.';
              if (value?.trim() != _passwordController.text.trim())
                return 'Die neuen Passwörter unterscheiden sich.';
              return null;
            },
            decoration: InputDecoration(
              labelText: 'neues Passwort bestätigen',
            ),
          ),
          SizedBox(height: 16),
          SecretTextFormField(
            focusNode: _oldPasswordFocus,
            onFieldSubmitted: (_) => _submit(),
            validator: (value) {
              if (value?.isEmpty ?? true)
                return 'Bitte altes Passwort eingeben.';
              return null;
            },
            onSaved: (value) => _oldPassword = value,
            decoration: InputDecoration(
              labelText: 'altes Passwort',
            ),
          ),
          if (_errorMessage != null) ...[
            SizedBox(height: 16),
            Row(
              children: [
                Spacer(),
                ErrorText(_errorMessage!),
              ],
            ),
          ],
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _submit,
              child: Text('Bestätigen'),
            ),
          ),
        ],
      ),
    );
  }
}

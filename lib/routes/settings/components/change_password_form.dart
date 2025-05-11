import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestures/components/form_fields/secret_text_form_field.dart';
import 'package:gestures/components/text/error_text.dart';
import 'package:gestures/firebase_auth_error.dart';
import 'package:micha_core/micha_core.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;
  String? _errorMessage;

  final _passwordController = TextEditingController();
  final _passwordFocus = FocusNode();
  final _confirmNewPasswordFocus = FocusNode();
  final _oldPasswordFocus = FocusNode();
  String? _newPassword;
  String? _oldPassword;

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
        const SnackBar(content: Text('Passwort wurde geändert.')),
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
        spacing: 16,
        children: [
          const ThemedText.headlineSmall('Passwort ändern'),
          SecretTextFormField(
            controller: _passwordController,
            focusNode: _passwordFocus,
            autofillHints: const [AutofillHints.newPassword],
            onFieldSubmitted: (_) => _confirmNewPasswordFocus.requestFocus(),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Bitte neues Passwort eingeben.';
              }
              return null;
            },
            onSaved: (value) => _newPassword = value,
            decoration: const InputDecoration(labelText: 'neues Passwort'),
          ),
          SecretTextFormField(
            focusNode: _confirmNewPasswordFocus,
            onFieldSubmitted: (_) => _oldPasswordFocus.requestFocus(),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Bitte neues Passwort eingeben.';
              }
              if (value?.trim() != _passwordController.text.trim()) {
                return 'Die neuen Passwörter unterscheiden sich.';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'neues Passwort bestätigen',
            ),
          ),
          SecretTextFormField(
            focusNode: _oldPasswordFocus,
            onFieldSubmitted: _isSubmitting ? null : (_) => _submit(),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Bitte altes Passwort eingeben.';
              }
              return null;
            },
            onSaved: (value) => _oldPassword = value,
            decoration: const InputDecoration(labelText: 'altes Passwort'),
          ),
          if (_errorMessage != null)
            Row(children: [const Spacer(), ErrorText(_errorMessage!)]),
          Row(
            children: [
              const Spacer(),
              if (_isSubmitting) const Spinner(size: 24),
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

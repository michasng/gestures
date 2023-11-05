import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestures/components/async/spinner.dart';
import 'package:gestures/components/form_fields/secret_text_form_field.dart';
import 'package:gestures/components/text/error_text.dart';
import 'package:gestures/components/text/headline_small.dart';
import 'package:gestures/components/text/links/link_text.dart';
import 'package:gestures/components/text/links/privacy_policy_link.dart';
import 'package:gestures/components/text/links/site_notice_link.dart';
import 'package:gestures/firebase_auth_error.dart';
import 'package:gestures/routes/auth/register/register_route.dart';
import 'package:gestures/routes/preface/preface_route.dart';
import 'package:gestures/routes/root_route.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;
  String? _errorMessage;

  final _passwordFocus = FocusNode();
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email!.trim(),
        password: _password!.trim(),
      );
      if (context.mounted) PrefaceRoute().go(context);
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
          HeadlineSmall('Anmelden'),
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
            onFieldSubmitted: _isSubmitting ? null : (_) => _submit(),
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
                ErrorText(_errorMessage!),
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
                  RegisterRoute().go(context);
                },
              ),
              Spacer(),
              if (_isSubmitting) ...[
                SizedBox(width: 16),
                Spinner(size: 24),
              ],
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                child: Text('Bestätigen'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

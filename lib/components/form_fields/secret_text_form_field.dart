import 'package:flutter/material.dart';

class SecretTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final InputDecoration? decoration;

  const SecretTextFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.autofillHints,
    this.onFieldSubmitted,
    this.validator,
    this.onSaved,
    this.decoration,
  });

  @override
  State<SecretTextFormField> createState() => _SecretTextFormFieldState();
}

class _SecretTextFormFieldState extends State<SecretTextFormField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    final decoration = widget.decoration ?? const InputDecoration();

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: _obscured,
      autofillHints: widget.autofillHints,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      onSaved: widget.onSaved,
      decoration: decoration.copyWith(
        suffixIcon: IconButton(
          onPressed: () => setState(() => _obscured = !_obscured),
          icon: Icon(
            _obscured ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final Object error;
  const ErrorScreen({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(error.toString()),
    );
  }
}

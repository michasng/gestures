import 'package:flutter/material.dart';
import 'package:gestures/components/spinner.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Spinner(),
    );
  }
}

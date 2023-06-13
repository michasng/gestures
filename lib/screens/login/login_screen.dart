import 'package:flutter/material.dart';
import 'package:gestures/components/app_title.dart';
import 'package:gestures/screens/login/components/login_form.dart';
import 'package:gestures/screens/package/components/logo.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTitle(),
      ),
      body: Column(
        children: [
          Spacer(),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: 400,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: LoginForm(),
                ),
              ),
            ),
          ),
          Spacer(),
          Logo(height: 100),
        ],
      ),
    );
  }
}

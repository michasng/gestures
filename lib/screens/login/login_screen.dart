import 'package:flutter/material.dart';
import 'package:gestures/components/app_background.dart';
import 'package:gestures/components/app_title.dart';
import 'package:gestures/components/centered_card.dart';
import 'package:gestures/screens/login/components/login_form.dart';
import 'package:gestures/screens/package/components/logo.dart';

class LoginScreen extends StatelessWidget {
  static const String path = '/login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        appBar: AppBar(
          title: AppTitle(),
        ),
        body: Column(
          children: [
            Spacer(),
            CenteredCard(
              width: 400,
              child: LoginForm(),
            ),
            Spacer(),
            Logo(height: 100),
          ],
        ),
      ),
    );
  }
}

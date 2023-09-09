import 'package:flutter/material.dart';
import 'package:gestures/components/app_background.dart';
import 'package:gestures/components/app_title.dart';
import 'package:gestures/components/centered_card.dart';
import 'package:gestures/screens/package/components/logo.dart';
import 'package:gestures/screens/register/components/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
              child: RegisterForm(),
            ),
            Spacer(),
            Logo(height: 100),
          ],
        ),
      ),
    );
  }
}

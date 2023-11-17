import 'package:flutter/material.dart';
import 'package:gestures/components/branding/app_background.dart';
import 'package:gestures/components/branding/logo.dart';
import 'package:gestures/components/centered_card.dart';
import 'package:gestures/components/text/app_title.dart';
import 'package:gestures/routes/auth/register/components/register_form.dart';
import 'package:go_router/go_router.dart';

class RegisterRoute extends GoRouteData {
  const RegisterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AppBackground(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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

import 'package:flutter/material.dart';
import 'package:gestures/components/branding/app_background.dart';
import 'package:gestures/components/branding/logo.dart';
import 'package:gestures/components/centered_card.dart';
import 'package:gestures/components/text/app_title.dart';
import 'package:gestures/routes/auth/reset_password_sent/components/reset_password_sent_notice.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordSentRoute extends GoRouteData {
  const ResetPasswordSentRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AppBackground(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const AppTitle(),
        ),
        body: const Column(
          children: [
            Spacer(),
            CenteredCard(width: 400, child: ResetPasswordSentNotice()),
            Spacer(),
            Logo(height: 100),
          ],
        ),
      ),
    );
  }
}

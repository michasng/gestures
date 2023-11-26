import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthStateBuilder extends StatelessWidget {
  final WidgetBuilder loadingBuilder;
  final WidgetBuilder unauthenticatedBuilder;
  final Widget Function(BuildContext context, User user) authenticatedBuilder;
  final Widget Function(BuildContext context, Object error) errorBuilder;

  const AuthStateBuilder({
    super.key,
    required this.loadingBuilder,
    required this.unauthenticatedBuilder,
    required this.authenticatedBuilder,
    required this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return loadingBuilder(context);
        }

        if (snapshot.hasError) return errorBuilder(context, snapshot.error!);

        if (!snapshot.hasData) return unauthenticatedBuilder(context);

        return authenticatedBuilder(context, snapshot.data!);
      },
    );
  }
}

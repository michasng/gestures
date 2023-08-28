import 'package:flutter/material.dart';
import 'package:gestures/components/app_title.dart';
import 'package:gestures/screens/preface/components/preface.dart';
import 'package:go_router/go_router.dart';

class PrefaceScreen extends StatelessWidget {
  const PrefaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTitle(),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Preface(),
              SizedBox(height: 64),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          context.go('/packages');
        },
        child: Text('Weiter zur App'),
      ),
    );
  }
}

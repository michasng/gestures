import 'package:flutter/material.dart';
import 'package:gestures/components/app_title.dart';
import 'package:gestures/components/screen_body.dart';
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
      body: ScreenBody(
        children: [
          Text(
            'Vorwort',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 32),
          Preface(),
          SizedBox(height: 64),
        ],
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

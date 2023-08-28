import 'package:flutter/material.dart';
import 'package:gestures/components/app_title.dart';
import 'package:gestures/components/asset_text.dart';
import 'package:gestures/components/screen_body.dart';
import 'package:go_router/go_router.dart';

class RequestAccessScreen extends StatelessWidget {
  const RequestAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: AppTitle(),
      ),
      body: ScreenBody(
        alignment: Alignment.topCenter,
        children: [
          Text('Zugriff erwerben', style: textTheme.titleLarge),
          SizedBox(height: 32),
          AssetText(path: 'assets/request_access.txt'),
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

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gestures/app_router.gr.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gebärde wählen')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Lautzeichen A'),
            onTap: () => AutoRouter.of(context).push(const GestureRoute()),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gestures/components/screen_body.dart';
import 'package:gestures/components/text/app_title.dart';
import 'package:gestures/components/text/asset_text.dart';
import 'package:gestures/routes/packages/packages_route.dart';
import 'package:gestures/routes/root_route.dart';
import 'package:go_router/go_router.dart';

class PrefaceRoute extends GoRouteData {
  const PrefaceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
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
          AssetText(path: 'assets/preface.txt'),
          SizedBox(height: 64),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          PackagesRoute().go(context);
        },
        child: Text('Weiter zur App'),
      ),
    );
  }
}

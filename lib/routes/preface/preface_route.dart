import 'package:flutter/material.dart';
import 'package:gestures/components/screen_body.dart';
import 'package:gestures/components/text/app_title.dart';
import 'package:gestures/routes/packages/packages_route.dart';
import 'package:gestures/routes/root_route.dart';
import 'package:go_router/go_router.dart';
import 'package:micha_core/micha_core.dart';

class PrefaceRoute extends GoRouteData {
  const PrefaceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: AppBar(
        title: const AppTitle(),
        automaticallyImplyLeading: false,
      ),
      body: ScreenBody(
        children: [
          const ThemedText.titleLarge('Vorwort'),
          const Gap() * 2,
          AsyncBuilder.asset(
            (assetBundle) => assetBundle.loadString('assets/preface.txt'),
            builder: (context, data) => Text(data),
          ),
        ],
      ),
      floatingActionButton: FilledButton(
        onPressed: () {
          const PackagesRoute().go(context);
        },
        child: const Text('Weiter zur App'),
      ),
    );
  }
}

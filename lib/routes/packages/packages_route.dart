import 'package:flutter/material.dart';
import 'package:gestures/components/branding/app_background.dart';
import 'package:gestures/components/text/app_title.dart';
import 'package:gestures/routes/packages/components/async_package_list.dart';
import 'package:gestures/routes/packages/components/main_menu_button.dart';
import 'package:go_router/go_router.dart';

class PackagesRoute extends GoRouteData {
  const PackagesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AppBackground(
      child: Scaffold(
        appBar: AppBar(
          title: AppTitle(),
          actions: [
            MainMenuButton(),
            SizedBox(width: 8),
          ],
        ),
        body: AsyncPackageList(),
      ),
    );
  }
}

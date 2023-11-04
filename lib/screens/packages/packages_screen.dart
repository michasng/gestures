import 'package:flutter/material.dart';
import 'package:gestures/components/app_background.dart';
import 'package:gestures/components/text/app_title.dart';
import 'package:gestures/screens/packages/components/async_package_list.dart';
import 'package:gestures/screens/packages/components/main_menu_button.dart';

class PackagesScreen extends StatelessWidget {
  static const String path = '/packages';

  const PackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

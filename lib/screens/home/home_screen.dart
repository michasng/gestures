import 'package:flutter/material.dart';
import 'package:gestures/components/app_background.dart';
import 'package:gestures/components/app_title.dart';
import 'package:gestures/screens/home/components/async_package_list.dart';
import 'package:gestures/screens/home/components/home_menu_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        appBar: AppBar(
          title: AppTitle(),
          actions: [
            HomeMenuButton(),
            SizedBox(width: 8),
          ],
        ),
        body: AsyncPackageList(),
      ),
    );
  }
}

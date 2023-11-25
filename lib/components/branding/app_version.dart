import 'package:flutter/material.dart';
import 'package:micha_core/micha_core.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AsyncBuilder(
      createFuture: (_) => PackageInfo.fromPlatform(),
      builder: (context, packageInfo) => Text(
        'App Version ${packageInfo.version}',
      ),
    );
  }
}

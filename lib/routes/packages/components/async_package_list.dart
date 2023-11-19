import 'package:flutter/material.dart';
import 'package:gestures/models/package.dart';
import 'package:gestures/routes/packages/components/package_list.dart';
import 'package:gestures/services/app_service.dart';
import 'package:get_it/get_it.dart';
import 'package:micha_core/micha_core.dart';

class AsyncPackageList extends StatelessWidget {
  const AsyncPackageList({super.key});

  Future<List<Package>> _load(BuildContext context) async {
    return await GetIt.I<AppService>().getPackages(context);
  }

  @override
  Widget build(BuildContext context) {
    return AsyncBuilder<List<Package>>(
      createFuture: (context) => _load(context),
      builder: (context, packages) {
        return PackageList(packages: packages);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gestures/components/async/async_view.dart';
import 'package:gestures/models/package.dart';
import 'package:gestures/screens/packages/components/package_list.dart';
import 'package:gestures/services/app_service.dart';
import 'package:get_it/get_it.dart';

class AsyncPackageList extends StatelessWidget {
  const AsyncPackageList({super.key});

  Future<List<Package>> _load(BuildContext context) async {
    return await GetIt.I<AppService>().getPackages(context);
  }

  @override
  Widget build(BuildContext context) {
    return AsyncView<List<Package>>(
      createFuture: () => _load(context),
      builder: (context, packages) {
        return PackageList(packages: packages);
      },
    );
  }
}

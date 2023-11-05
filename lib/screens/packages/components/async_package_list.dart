import 'package:flutter/material.dart';
import 'package:gestures/components/async/app_future_builder.dart';
import 'package:gestures/models/package.dart';
import 'package:gestures/screens/packages/components/package_list.dart';
import 'package:gestures/services/app_service.dart';
import 'package:get_it/get_it.dart';

class AsyncPackageList extends StatefulWidget {
  const AsyncPackageList({super.key});

  @override
  State<AsyncPackageList> createState() => _AsyncPackageListState();
}

class _AsyncPackageListState extends State<AsyncPackageList> {
  late Future<List<Package>> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = GetIt.I<AppService>().getPackages(context);
  }

  @override
  Widget build(BuildContext context) {
    return AppFutureBuilder<List<Package>>(
      future: _loadFuture,
      builder: (context, packages) {
        return PackageList(packages: packages);
      },
    );
  }
}

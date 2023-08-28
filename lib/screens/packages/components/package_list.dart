import 'package:flutter/material.dart';
import 'package:gestures/models/package.dart';
import 'package:gestures/screens/packages/components/package_list_tile.dart';
import 'package:gestures/services/app_service.dart';
import 'package:get_it/get_it.dart';

class PackageList extends StatelessWidget {
  final List<Package> packages;

  const PackageList({
    super.key,
    required this.packages,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appService = GetIt.I<AppService>();

    return ListView(
      children: [
        PackageListTile(
          package: appService.createAllGesturesPackage(packages),
        ),
        Divider(),
        ListTile(
          title: Text(
            'Pakete',
            style: theme.textTheme.headlineSmall
                ?.copyWith(color: theme.colorScheme.onPrimary),
          ),
        ),
        for (final package in packages) PackageListTile(package: package),
      ],
    );
  }
}

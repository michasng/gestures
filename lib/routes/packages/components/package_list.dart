import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gestures/models/package.dart';
import 'package:gestures/routes/packages/components/package_list_tile.dart';
import 'package:gestures/routes/packages/components/search_all_list_tile.dart';

class PackageList extends StatelessWidget {
  final List<Package> packages;

  const PackageList({
    super.key,
    required this.packages,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final allGesturesCount =
        packages.map((package) => package.gestures.length).sum;

    return ListView(
      children: [
        SearchAllListTile(allGesturesCount: allGesturesCount),
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

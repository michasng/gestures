import 'package:flutter/material.dart';
import 'package:gestures/models/package.dart';
import 'package:gestures/screens/home/components/package_list_tile.dart';

class PackageList extends StatelessWidget {
  final List<Package> packages;

  const PackageList({
    super.key,
    required this.packages,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final allGestures = [...packages.expand((p) => p.gestures)];
    allGestures.sort((g1, g2) => g1.title.compareTo(g2.title));

    return ListView(
      children: [
        PackageListTile(
          package: Package(
            title: 'Alle Gebärden durchsuchen',
            gestures: allGestures,
          ),
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

import 'package:flutter/material.dart';
import 'package:gestures/models/package.dart';
import 'package:gestures/routes/packages/package/package_route.dart';
import 'package:gestures/routes/root_route.dart';

class PackageListTile extends StatelessWidget {
  final Package package;

  const PackageListTile({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: ListTile(
        textColor: theme.colorScheme.onSurface,
        title: Text(package.title),
        subtitle: Text('${package.gestures.length} Videoclips'),
        onTap: () => PackageRoute(
          packageId: package.title,
        ).go(context),
        trailing: Icon(
          package.icon,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gestures/models/package.dart';
import 'package:go_router/go_router.dart';

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
        onTap: () => context.go('/packages/${package.title}'),
        trailing: Icon(
          package.icon,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gestures/routes/packages/search_all/search_all_route.dart';
import 'package:gestures/routes/root_route.dart';

class SearchAllListTile extends StatelessWidget {
  final int allGesturesCount;

  const SearchAllListTile({super.key, required this.allGesturesCount});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: ListTile(
        textColor: theme.colorScheme.onSurface,
        title: const Text('Alle Gebärden durchsuchen'),
        subtitle: Text('$allGesturesCount Videoclips'),
        onTap: () => const SearchAllRoute().go(context),
        trailing: Icon(
          Icons.search,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gestures/screens/search_all/search_all_screen.dart';
import 'package:go_router/go_router.dart';

class SearchAllListTile extends StatelessWidget {
  final int allGesturesCount;

  const SearchAllListTile({super.key, required this.allGesturesCount});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: ListTile(
        textColor: theme.colorScheme.onSurface,
        title: Text('Alle Gebärden durchsuchen'),
        subtitle: Text('$allGesturesCount Videoclips'),
        onTap: () => context.go(SearchAllScreen.path),
        trailing: Icon(
          Icons.search,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}

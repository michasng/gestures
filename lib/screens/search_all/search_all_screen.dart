import 'package:flutter/material.dart';
import 'package:gestures/screens/packages/packages_screen.dart';
import 'package:gestures/screens/search_all/components/async_all_gestures_list.dart';

class SearchAllScreen extends StatefulWidget {
  static const String pathSegment = 'search_all';
  static const String path = '${PackagesScreen.path}/$pathSegment';

  const SearchAllScreen({super.key});

  @override
  State<SearchAllScreen> createState() => _SearchAllScreenState();
}

class _SearchAllScreenState extends State<SearchAllScreen> {
  final _asyncAllGesturesListKey = GlobalKey<AsyncAllGesturesListState>();

  void _search(String search) {
    _asyncAllGesturesListKey.currentState?.search(search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text('Alle Gebärden durchsuchen'),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Suche',
              ),
              onChanged: _search,
            ),
          ),
          Expanded(
            child: AsyncAllGesturesList(
              key: _asyncAllGesturesListKey,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gestures/models/package.dart';
import 'package:gestures/screens/package/components/gesture_list.dart';
import 'package:gestures/screens/package/components/search_bar.dart';

class PackageScreen extends StatelessWidget {
  final Package package;
  final _gestureListKey = GlobalKey<GestureListState>();

  PackageScreen({super.key, required this.package});

  void _search(String search) {
    _gestureListKey.currentState!.search(search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(package.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBar(
              onSearch: _search,
            ),
          ),
          Expanded(
            child: GestureList(
              package: package,
              key: _gestureListKey,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gestures/screens/package/components/async_gesture_list.dart';

class PackageScreen extends StatefulWidget {
  final String packageId;

  const PackageScreen({super.key, required this.packageId});

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  final _asyncGestureListKey = GlobalKey<AsyncGestureListState>();

  void _search(String search) {
    _asyncGestureListKey.currentState?.search(search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: FittedBox(child: Text(widget.packageId))),
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
            child: AsyncGestureList(
              key: _asyncGestureListKey,
              packageId: widget.packageId,
            ),
          ),
        ],
      ),
    );
  }
}

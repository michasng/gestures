import 'package:flutter/material.dart';
import 'package:gestures/components/app_future_builder.dart';
import 'package:gestures/models/package.dart';
import 'package:gestures/screens/package/components/gesture_list.dart';
import 'package:gestures/services/app_service.dart';
import 'package:get_it/get_it.dart';

class AsyncGestureList extends StatefulWidget {
  final String packageId;

  const AsyncGestureList({
    super.key,
    required this.packageId,
  });

  @override
  State<AsyncGestureList> createState() => AsyncGestureListState();
}

class AsyncGestureListState extends State<AsyncGestureList> {
  final _gestureListKey = GlobalKey<GestureListState>();
  late Future<Package> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = GetIt.I<AppService>().loadPackage(
      context,
      packageId: widget.packageId,
    );
  }

  void search(String search) {
    _gestureListKey.currentState?.search(search);
  }

  @override
  Widget build(BuildContext context) {
    return AppFutureBuilder<Package>(
      future: _loadFuture,
      builder: (context, package) => GestureList(
        key: _gestureListKey,
        package: package,
      ),
    );
  }
}

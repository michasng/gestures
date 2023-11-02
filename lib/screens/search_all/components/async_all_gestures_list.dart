import 'package:flutter/material.dart';
import 'package:gestures/components/app_future_builder.dart';
import 'package:gestures/models/gesture.dart';
import 'package:gestures/screens/package/components/gesture_list.dart';
import 'package:gestures/services/app_service.dart';
import 'package:get_it/get_it.dart';

class AsyncAllGesturesList extends StatefulWidget {
  const AsyncAllGesturesList({
    super.key,
  });

  @override
  State<AsyncAllGesturesList> createState() => AsyncAllGesturesListState();
}

class AsyncAllGesturesListState extends State<AsyncAllGesturesList> {
  final _gestureListKey = GlobalKey<GestureListState>();
  late Future<List<Gesture>> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = GetIt.I<AppService>().getAllGestures(context);
  }

  void search(String search) {
    _gestureListKey.currentState?.search(search);
  }

  @override
  Widget build(BuildContext context) {
    return AppFutureBuilder<List<Gesture>>(
      future: _loadFuture,
      builder: (context, gestures) => GestureList(
        key: _gestureListKey,
        gestures: gestures,
      ),
    );
  }
}

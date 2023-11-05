import 'package:flutter/material.dart';
import 'package:gestures/components/async/app_future_builder.dart';
import 'package:gestures/models/distinct_gesture.dart';
import 'package:gestures/screens/gesture/components/carousel_controls.dart';
import 'package:gestures/screens/gesture/components/gesture_view.dart';
import 'package:gestures/services/app_service.dart';
import 'package:get_it/get_it.dart';

class AsyncGestureView extends StatefulWidget {
  final String packageId;
  final String gestureId;
  final void Function(int delta) goToPageDelta;

  const AsyncGestureView({
    super.key,
    required this.packageId,
    required this.gestureId,
    required this.goToPageDelta,
  });

  @override
  State<AsyncGestureView> createState() => _AsyncGestureViewState();
}

class _AsyncGestureViewState extends State<AsyncGestureView> {
  late Future<DistinctGesture> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = GetIt.I<AppService>().getPackageGesture(
      context,
      packageId: widget.packageId,
      gestureId: widget.gestureId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppFutureBuilder<DistinctGesture>(
      future: _loadFuture,
      builder: (context, gesture) => GestureView(
        gesture: gesture,
        controlsChild: CarouselControls(
          gesture: gesture,
          onPrevious: () => widget.goToPageDelta(-1),
          onNext: () => widget.goToPageDelta(1),
        ),
      ),
    );
  }
}

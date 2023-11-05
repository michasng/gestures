import 'package:flutter/material.dart';
import 'package:gestures/components/async/async_view.dart';
import 'package:gestures/models/distinct_gesture.dart';
import 'package:gestures/screens/gesture/components/carousel_controls.dart';
import 'package:gestures/screens/gesture/components/gesture_view.dart';
import 'package:gestures/services/app_service.dart';
import 'package:get_it/get_it.dart';

class AsyncGestureView extends StatelessWidget {
  final String packageId;
  final String gestureId;
  final void Function(int delta) goToPageDelta;

  const AsyncGestureView({
    super.key,
    required this.packageId,
    required this.gestureId,
    required this.goToPageDelta,
  });

  Future<DistinctGesture> _load(BuildContext context) async {
    return await GetIt.I<AppService>().getPackageGesture(
      context,
      packageId: packageId,
      gestureId: gestureId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AsyncView<DistinctGesture>(
      createFuture: () => _load(context),
      builder: (context, gesture) => GestureView(
        gesture: gesture,
        controlsChild: CarouselControls(
          gesture: gesture,
          onPrevious: () => goToPageDelta(-1),
          onNext: () => goToPageDelta(1),
        ),
      ),
    );
  }
}

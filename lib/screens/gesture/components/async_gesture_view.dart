import 'package:flutter/material.dart';
import 'package:gestures/components/app_future_builder.dart';
import 'package:gestures/models/gesture.dart';
import 'package:gestures/screens/gesture/components/carousel_controls.dart';
import 'package:gestures/screens/gesture/components/gesture_view.dart';
import 'package:gestures/services/app_service.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AsyncGestureView extends StatefulWidget {
  final String packageId;
  final String gestureId;

  const AsyncGestureView({
    super.key,
    required this.packageId,
    required this.gestureId,
  });

  @override
  State<AsyncGestureView> createState() => _AsyncGestureViewState();
}

class _AsyncGestureViewState extends State<AsyncGestureView> {
  late Future<Gesture> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = GetIt.I<AppService>().loadGesture(
      context,
      packageId: widget.packageId,
      gestureId: widget.gestureId,
    );
  }

  void _goToPageDelta(int delta) async {
    final router = GoRouter.of(context);
    final package = await GetIt.I<AppService>().loadPackage(
      context,
      packageId: widget.packageId,
    );
    final currentIndex = package.gestures
        .indexWhere((gesture) => gesture.title == widget.gestureId);
    final newIndex = (currentIndex + delta) % package.gestures.length;
    final newGesture = package.gestures[newIndex];
    router.go('/packages/${widget.packageId}/gestures/${newGesture.title}');
  }

  @override
  Widget build(BuildContext context) {
    return AppFutureBuilder<Gesture>(
      future: _loadFuture,
      builder: (context, gesture) => GestureView(
        gesture: gesture,
        controlsChild: CarouselControls(
          gesture: gesture,
          onPrevious: () => _goToPageDelta(-1),
          onNext: () => _goToPageDelta(1),
        ),
      ),
    );
  }
}

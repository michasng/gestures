import 'package:flutter/material.dart';
import 'package:gestures/models/distinct_gesture.dart';
import 'package:gestures/routes/packages/package/gesture/components/async_gesture_view.dart';
import 'package:gestures/routes/packages/package/package_route.dart';
import 'package:gestures/routes/packages/search_all/search_all_route.dart';
import 'package:gestures/routes/root_route.dart';
import 'package:gestures/services/app_service.dart';
import 'package:gestures/services/search_service.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class GestureRoute extends GoRouteData {
  final String packageId;
  final String gestureId;
  final String? searchKey;
  final bool searchingAll;

  const GestureRoute({
    required this.packageId,
    required this.gestureId,
    this.searchKey,
    this.searchingAll = false,
  });

  Future<List<DistinctGesture>> _getGestures(BuildContext context) async {
    final appService = GetIt.I<AppService>();
    if (searchingAll) {
      return await appService.getAllGestures(context);
    }
    final package = await GetIt.I<AppService>().getPackage(
      context,
      packageId: packageId,
    );
    return package.gestures;
  }

  Future<List<DistinctGesture>> _search(BuildContext context) async {
    final gestures = await _getGestures(context);
    if (searchKey == null || searchKey!.isEmpty) return gestures;
    final searchService = GetIt.I<SearchService>();
    return searchService.search(gestures, searchKey!);
  }

  void _goToPageDelta(BuildContext context, int delta) async {
    final gestures = await _search(context);
    final currentIndex =
        gestures.indexWhere((gesture) => gesture.id == gestureId);
    final newIndex = (currentIndex + delta) % gestures.length;
    final newGesture = gestures[newIndex];
    if (!context.mounted) return;
    GestureRoute(
      packageId: newGesture.package.id,
      gestureId: newGesture.id,
      searchKey: searchKey,
      searchingAll: searchingAll,
    ).go(context);
  }

  void _navigateBack(BuildContext context) {
    if (searchingAll) {
      SearchAllRoute(
        initialSearchKey: searchKey,
      ).go(context);
    } else {
      PackageRoute(
        packageId: packageId,
        initialSearchKey: searchKey,
      ).go(context);
    }
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _navigateBack(context),
        ),
        title: FittedBox(
          child: Text(gestureId),
        ),
      ),
      body: AsyncGestureView(
        key: ValueKey('$packageId, $gestureId'),
        packageId: packageId,
        gestureId: gestureId,
        goToPageDelta: (delta) => _goToPageDelta(context, delta),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gestures/components/gesture_list/searchable_gesture_list.dart';
import 'package:gestures/models/distinct_gesture.dart';
import 'package:gestures/routes/packages/package/gesture/gesture_route.dart';
import 'package:gestures/routes/root_route.dart';
import 'package:gestures/services/app_service.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:micha_core/micha_core.dart';

class SearchAllRoute extends GoRouteData {
  final String? initialSearchKey;

  const SearchAllRoute({
    this.initialSearchKey,
  });

  Future<List<DistinctGesture>> _load(BuildContext context) async {
    return await GetIt.I<AppService>().getAllGestures(context);
  }

  void _navigateToGesture(
    BuildContext context,
    DistinctGesture gesture,
    String? searchKey,
  ) {
    GestureRoute(
      packageId: gesture.package.id,
      gestureId: gesture.id,
      searchKey: searchKey,
      searchingAll: true,
    ).go(context);
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text('Alle Gebärden durchsuchen'),
        ),
      ),
      body: AsyncBuilder(
        createFuture: (context) => _load(context),
        builder: (context, gestures) => SearchableGestureList(
          gestures: gestures,
          initialSearchKey: initialSearchKey,
          showPackageTitles: true,
          onTapGesture: (gesture, searchKey) => _navigateToGesture(
            context,
            gesture,
            searchKey,
          ),
        ),
      ),
    );
  }
}

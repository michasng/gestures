import 'package:flutter/material.dart';
import 'package:gestures/components/async/async_view.dart';
import 'package:gestures/components/gesture_list/searchable_gesture_list.dart';
import 'package:gestures/models/distinct_gesture.dart';
import 'package:gestures/models/package.dart';
import 'package:gestures/routes/packages/package/gesture/gesture_route.dart';
import 'package:gestures/routes/root_route.dart';
import 'package:gestures/services/app_service.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class PackageRoute extends GoRouteData {
  final String packageId;
  final String? initialSearchKey;

  const PackageRoute({
    required this.packageId,
    this.initialSearchKey,
  });

  Future<Package> _load(BuildContext context) async {
    return await GetIt.I<AppService>().getPackage(
      context,
      packageId: packageId,
    );
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
      searchingAll: false,
    ).go(context);
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(packageId),
        ),
      ),
      body: AsyncView(
        createFuture: () => _load(context),
        builder: (context, package) => SearchableGestureList(
          gestures: package.gestures,
          initialSearchKey: initialSearchKey,
          showPackageTitles: false,
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

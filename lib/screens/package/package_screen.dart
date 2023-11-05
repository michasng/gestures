import 'package:flutter/material.dart';
import 'package:gestures/components/async/async_view.dart';
import 'package:gestures/models/distinct_gesture.dart';
import 'package:gestures/models/package.dart';
import 'package:gestures/screens/gesture/gesture_screen.dart';
import 'package:gestures/screens/package/components/searchable_gesture_list.dart';
import 'package:gestures/screens/packages/packages_screen.dart';
import 'package:gestures/services/app_service.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class PackageScreen extends StatelessWidget {
  static const String pathSegment = ':packageId';
  static String path({required String packageId}) {
    return '${PackagesScreen.path}/$packageId';
  }

  final String packageId;

  const PackageScreen({super.key, required this.packageId});

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
    context.go(
      GestureScreen.path(
        packageId: gesture.package.id,
        gestureId: gesture.id,
        searchKey: searchKey,
        searchingAll: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          initialSearchKey: null,
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

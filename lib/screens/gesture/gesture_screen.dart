import 'package:flutter/material.dart';
import 'package:gestures/components/routing.dart';
import 'package:gestures/models/distinct_gesture.dart';
import 'package:gestures/screens/gesture/components/async_gesture_view.dart';
import 'package:gestures/screens/package/package_screen.dart';
import 'package:gestures/screens/packages/packages_screen.dart';
import 'package:gestures/screens/search_all/search_all_screen.dart';
import 'package:gestures/services/app_service.dart';
import 'package:gestures/services/search_service.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class GestureScreen extends StatelessWidget {
  static const String pathSegment = 'gestures/:gestureId';
  static String path({
    required String packageId,
    required String gestureId,
    required String? searchKey,
    required bool searchingAll,
  }) {
    final queryString = createQueryString({
      'search_key': searchKey,
      'searching_all': searchingAll,
    });

    return '${PackagesScreen.path}/$packageId/gestures/$gestureId$queryString';
  }

  final String packageId;
  final String gestureId;
  final String? searchKey;
  final bool searchingAll;

  const GestureScreen({
    super.key,
    required this.packageId,
    required this.gestureId,
    required this.searchKey,
    required this.searchingAll,
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
    final router = GoRouter.of(context);
    final gestures = await _search(context);
    final currentIndex =
        gestures.indexWhere((gesture) => gesture.id == gestureId);
    final newIndex = (currentIndex + delta) % gestures.length;
    final newGesture = gestures[newIndex];
    router.go(
      GestureScreen.path(
        packageId: newGesture.package.id,
        gestureId: newGesture.id,
        searchKey: searchKey,
        searchingAll: searchingAll,
      ),
    );
  }

  void _navigateBack(BuildContext context) {
    if (searchingAll) {
      context.go(
        SearchAllScreen.path(
          searchKey: searchKey,
        ),
      );
    } else {
      context.go(
        PackageScreen.path(
          packageId: packageId,
          searchKey: searchKey,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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

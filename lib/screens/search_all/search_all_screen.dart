import 'package:flutter/material.dart';
import 'package:gestures/components/async/async_view.dart';
import 'package:gestures/models/distinct_gesture.dart';
import 'package:gestures/screens/gesture/gesture_screen.dart';
import 'package:gestures/screens/package/components/searchable_gesture_list.dart';
import 'package:gestures/screens/packages/packages_screen.dart';
import 'package:gestures/services/app_service.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class SearchAllScreen extends StatelessWidget {
  static const String pathSegment = 'search_all';
  static const String path = '${PackagesScreen.path}/$pathSegment';

  const SearchAllScreen({super.key});

  Future<List<DistinctGesture>> _load(BuildContext context) async {
    return await GetIt.I<AppService>().getAllGestures(context);
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
        searchingAll: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text('Alle Gebärden durchsuchen'),
        ),
      ),
      body: AsyncView(
        createFuture: () => _load(context),
        builder: (context, gestures) => SearchableGestureList(
          gestures: gestures,
          initialSearchKey: null,
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

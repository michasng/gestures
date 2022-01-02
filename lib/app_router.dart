import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:gestures/screens/gesture/gesture_screen.dart';
import 'package:gestures/screens/home/home_screen.dart';

// routes with parameters require usePathAsKey to be true
// https://stackoverflow.com/questions/69700775/how-do-i-refresh-the-current-route-when-arguments-change
@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: HomeScreen,
      initial: true,
    ),
    AutoRoute(
      path: '/gesture',
      page: GestureScreen,
    ),
  ],
)
class $AppRouter {}

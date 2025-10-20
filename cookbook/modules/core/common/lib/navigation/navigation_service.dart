import 'package:flutter/material.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  static List<String> routeHistory = [];
  BuildContext? get currentContext => navigatorKey.currentContext;
}

class NavigationObserver extends RouteObserver<ModalRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    try {
      if (route is! ModalBottomSheetRoute) {
        NavigationService.routeHistory.add(
            GoRouter.of(route.navigator!.context)
                .routeInformationProvider
                .value
                .uri.path
        );
      }
    } catch (_) {}
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      try {
        NavigationService.routeHistory.add(
            GoRouter.of(newRoute.navigator!.context)
                .routeInformationProvider
                .value
                .uri.path
        );
      } catch (_) {}
    }
  }
}
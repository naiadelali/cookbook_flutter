import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import 'navigation_service.dart';

class RouterNavigation {
  RouterNavigation._();

  static GoRouter _router(BuildContext? context) =>
      GoRouter.of(context ?? NavigationService.navigatorKey.currentContext!);

  static Future<T?> push<T extends Object?>(String location, {BuildContext? context, Object? extra}) async {
    if (kIsWeb) {
      go(location, context: context, extra: extra);
      return null;
    }
    return _router(context).push<T>(location, extra: extra);
  }

  static void go(String location, {BuildContext? context, Object? extra}) =>
      _router(context).go(location, extra: extra);

  static void pop<T extends Object?>([T? result]) =>
      _router(NavigationService.navigatorKey.currentContext).pop(result);

  static bool canPop({BuildContext? context}) => _router(context).canPop();

  static void pushReplacement(String location, {Object? extra, BuildContext? context}) =>
      kIsWeb
          ? go(location, context: context, extra: extra)
          : _router(context).pushReplacement(location, extra: extra);
}
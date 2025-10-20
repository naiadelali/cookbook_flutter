import 'package:core_common/navigation/navigation_service.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

GoRoute createRoute({
  required String path,
  required GoRouterWidgetBuilder builder,
  GoRouterWidgetBuilder? webBuilder,
  List<RouteBase> routes = const [],
  bool withParentRootKey = true,
}) {
  return GoRoute(
      parentNavigatorKey: withParentRootKey
          ? NavigationService.navigatorKey : null,
      path: path,
      routes: routes,
      builder: (context, state) {
        var child = kIsWeb && webBuilder != null
            ? webBuilder.call(context, state)
            : builder.call(context, state);

        return child;
      }
  );
}
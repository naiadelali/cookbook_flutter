import 'package:auth/auth.dart';
import 'package:core_common/navigation/navigation_service.dart';
import 'package:home/home.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

var goRouter = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    observers: [],
    initialLocation: AuthRoutes.login,
    redirect: (context, state) async {
      if (state.matchedLocation.contains(AuthRoutes.login)) {
        return null;
      }

      // var appState = context.read<AppState>();
      // return appState.session != null ? null : AuthRoutes.login;
      return null;
    },
    routes: [
      authRoutes,
      homeRoutes,
      dsRoutes,
    ]
);

import 'package:auth/auth.dart';
import 'package:core_common/navigation/app_navigation.dart';
import 'package:core_common/navigation/router_navigation.dart';
import 'package:home/home.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

class AppNavigationImpl implements AppNavigation {
  @override
  void goToAuth() => RouterNavigation.push(AuthRoutes.login);

  @override
  void goToExamples() => RouterNavigation.push(DsRoutes.base);

  @override
  void goToHome() => RouterNavigation.push(HomeRoutes.home);

}
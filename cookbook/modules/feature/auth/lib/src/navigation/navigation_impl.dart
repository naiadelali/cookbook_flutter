import 'package:auth/src/navigation/navigation.dart';
import 'package:auth/src/navigation/routes.dart';
import 'package:core_common/navigation/router_navigation.dart';

class AuthNavigationImpl implements AuthNavigation {
  @override
  void pop() => RouterNavigation.pop();

  @override
  void goToRegister() => RouterNavigation.push(AuthRoutes.register);

  @override
  void goToAuth() => RouterNavigation.go(AuthRoutes.login);
}
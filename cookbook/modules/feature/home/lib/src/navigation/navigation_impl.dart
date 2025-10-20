import 'package:core_common/navigation/router_navigation.dart';
import 'navigation.dart';

class HomeNavigationImpl implements HomeNavigation {
  @override
  void pop() => RouterNavigation.pop();
}
import 'package:core_common/navigation/router_navigation.dart';
import 'package:ds/src/navigation/navigation.dart';

class DsNavigationImpl implements DsNavigation {

  @override
  void pop() => RouterNavigation.pop();
}
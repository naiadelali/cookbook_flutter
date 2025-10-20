import 'package:home/src/navigation/navigation.dart';
import 'package:home/src/navigation/navigation_impl.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

final _getIt = GetIt.I;

void homeInjection() {
  _getIt.registerSingleton<HomeNavigation>(HomeNavigationImpl());
}
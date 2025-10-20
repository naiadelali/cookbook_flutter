import 'package:auth/src/navigation/navigation.dart';
import 'package:auth/src/navigation/navigation_impl.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

final _getIt = GetIt.I;

void authInjection() {
  _getIt.registerSingleton<AuthNavigation>(AuthNavigationImpl());
}

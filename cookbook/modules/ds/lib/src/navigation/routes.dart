import 'package:core_common/navigation/navigation_utils.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

class DsRoutes {
  DsRoutes._();

  static const base = '/ds';
}

extension _Navigation on String {
  String get removeBase => replaceFirst('${DsRoutes.base}/', '');
}

final dsRoutes = createRoute(
  path: DsRoutes.base,
  builder: (context, state) => DsExamplesPage(),
  routes: [],
);

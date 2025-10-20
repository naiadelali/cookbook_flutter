import 'package:home/src/ui/state/cubit/home_cubit.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

final _getIt = GetIt.I;

final homeCubits = [
  BlocProvider(create: (_) =>
      HomeCubit(_getIt()),
  ),
];
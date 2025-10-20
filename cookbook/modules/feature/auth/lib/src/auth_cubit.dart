import 'package:auth/src/ui/state/cubit/sign_in_cubit.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

final _getIt = GetIt.I;

final authCubits = [
  BlocProvider(create: (_) =>
      SignInCubit(_getIt(), _getIt(), _getIt(), _getIt(), _getIt(), _getIt(),),
  ),
];
import 'package:auth/src/ui/sign_in/sign_in_page.dart';
import 'package:core_common/navigation/navigation_utils.dart';

class AuthRoutes {
  AuthRoutes._();

  static const login = '/auth';
  static const recoverPassword = '$login/recover-password';
  static const newPassword = '$login/new-password';
  static const register = '$login/simple-completion';
}

extension _Navigation on String {
  String get removeBase => replaceFirst('${AuthRoutes.login}/', '');
}

final authRoutes = createRoute(
  path: AuthRoutes.login,
  builder: (context, state) => SignInPage(),
  routes: [
    createRoute(
      path: AuthRoutes.register.removeBase,
      builder: (context, state) => SignInPage(),
    ),
  ],
);

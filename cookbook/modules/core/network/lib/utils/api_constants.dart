import 'package:core_common/utils/env.dart';

class ApiConstants {
  // Using ReqRes as example public API (https://reqres.in/)
  static String baseUrl =
      Env.baseUrl.isNotEmpty ? Env.baseUrl : "https://reqres.in";

  static String get api => "$baseUrl/api";

  // AUTH
  static String get login => "$api/login";
  static String get logout => "$api/logout";
  static String get register => "$api/register";

  // USER
  static String get users => "$api/users";
}

class Env {
  Env._();

  static final baseUrl = const String.fromEnvironment('BASE_URL');
  static final clientId = const String.fromEnvironment('CLIENT_ID');
  static final clientSecret = const String.fromEnvironment('CLIENT_SECRET');
}
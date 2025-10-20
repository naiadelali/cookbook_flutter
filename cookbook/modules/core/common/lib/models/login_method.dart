enum LoginMethod {
  email("email"),
  acr("acr"),
  address("address"),
  microProfile("microprofile-jwt"),
  offlineAccess("offline_access"),
  phone("phone"),
  profile("profile"),
  roleList("role_list"),
  roles("roles"),
  webOrigins("web-origins");

  final String value;

  const LoginMethod(this.value);
}

class SessionResponse {
  final String? accessToken;
  final String? refreshToken;
  final int? expiresIn;
  final int? refreshExpiresIn;
  final String? tokenType;
  final String? notBeforePolicy;
  final String? sessionState;
  final String? scope;

  SessionResponse({
    this.accessToken,
    this.refreshToken,
    this.expiresIn,
    this.refreshExpiresIn,
    this.tokenType,
    this.notBeforePolicy,
    this.sessionState,
    this.scope,
  });

  factory SessionResponse.fromMap(Map<String, dynamic> json) {
    return SessionResponse(
      accessToken: json["access_token"],
      refreshToken: json["refresh_token"],
      expiresIn: json["expires_in"],
      refreshExpiresIn: json["refresh_expires_in"],
      tokenType: json["token_type"],
      notBeforePolicy: json[
          "not-before-policy"], //TODO: Verify if is '-' or '_' in this serialized name
      sessionState: json["session_state"],
      scope: json["scope"],
    );
  }
}

class UserSession {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;
  final String scope;

  UserSession({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
    required this.scope,
  });
}

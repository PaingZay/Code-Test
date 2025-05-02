import 'package:interview_test/features/auth/domain/entities/user_session.dart';

class UserSessionModel extends UserSession {
  UserSessionModel({
    required super.accessToken,
    required super.refreshToken,
    required super.tokenType,
    required super.expiresIn,
    required super.scope,
  });

  factory UserSessionModel.fromJson(Map<String, dynamic> json) {
    return UserSessionModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
      scope: json['scope'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'scope': scope,
    };
  }
}

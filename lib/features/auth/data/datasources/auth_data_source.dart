import 'dart:convert';
import 'package:interview_test/core/enum.dart';
import 'package:interview_test/core/api_service.dart';
import 'package:interview_test/features/auth/data/models/auth_response_model.dart';
import 'package:interview_test/features/auth/data/models/user_session.dart';

class AuthDataSource {
  final ApiService _apiService;

  AuthDataSource(this._apiService);

  static const String baseUrl = 'https://dev.gigagates.com/qq-delivery-backend';

  Future<UserSessionModel?> requestNewAccessToken(
    String username,
    String password,
  ) async {
    final url = '$baseUrl/v3/user/';
    final response = await _apiService.apiCall(
      url: url,
      method: HttpMethod.POST,
      headers: {'Content-Type': 'application/json'},
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final loginResponse = ResponseModel.fromJson(data);

      if (loginResponse.success) {
        return loginResponse.data; // This can be null
      } else {
        throw Exception('Error: ${loginResponse.message}');
      }
    } else {
      throw Exception('Failed to request new access token: ${response.body}');
    }
  }

  Future<UserSessionModel> requestNewAccessTokenFromRefreshToken(
    String refreshToken,
  ) async {
    final url = '$baseUrl/v3/user/refresh_token';
    final response = await _apiService.apiCall(
      url: url,
      method: HttpMethod.POST,
      body: {'accessToken': refreshToken},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final userSession = UserSessionModel.fromJson(data);
      return userSession;
    } else {
      throw Exception(
        'Failed to request new access token from refresh token: ${response.body}',
      );
    }
  }

  Future<bool> revokeAccessToken(String accessToken) async {
    final url = '$baseUrl/v3/user/revoke_access_token_by_username';
    try {
      final response = await _apiService.apiCall(
        url: url,
        method: HttpMethod.POST,
        body: {},
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final authResponse = ResponseModel.fromJson(data);
        if (authResponse.success) {
          return true;
        } else {
          throw Exception('Error: ${authResponse.message}');
        }
      } else {
        throw Exception('Failed to revoke access token: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to revoke access token: $e');
    }
  }
}

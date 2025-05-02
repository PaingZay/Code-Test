import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:interview_test/features/auth/data/datasources/auth_data_source.dart';
import 'package:interview_test/features/auth/domain/entities/user_session.dart';
import 'package:interview_test/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.dataSource, required this.storage});

  final AuthDataSource dataSource;
  final FlutterSecureStorage storage;

  @override
  Future<UserSession> login(String username, String password) async {
    try {
      final userSession = await dataSource.requestNewAccessToken(
        username,
        password,
      );

      if (userSession == null) {
        throw Exception('userSession is empty.');
      }

      await storage.write(key: 'access_token', value: userSession.accessToken);
      await storage.write(
        key: 'refresh_token',
        value: userSession.refreshToken,
      );

      return userSession;
    } catch (e) {
      if (kDebugMode) {
        print('Error during login: $e');
      }
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<UserSession> refresh() {
    return storage.read(key: 'refresh_token').then((refreshToken) async {
      if (refreshToken == null) {
        throw Exception('No refresh token found');
      }

      final userSession = await dataSource
          .requestNewAccessTokenFromRefreshToken(refreshToken);

      await storage.write(key: 'access_token', value: userSession.accessToken);

      return userSession;
    });
  }

  @override
  Future<bool> logout() async {
    try {
      final accessToken = await storage.read(key: 'access_token');

      if (accessToken == null) {
        throw Exception('No access token found');
      }

      final result = await dataSource.revokeAccessToken(accessToken);

      return storage.delete(key: 'access_token').then((_) async {
        await storage.delete(key: 'refresh_token');
        return result;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error during logout: $e');
      }
      throw Exception('Failed to logout: $e');
    }
  }
}

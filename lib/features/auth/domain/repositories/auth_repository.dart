import 'package:interview_test/features/auth/domain/entities/user_session.dart';

abstract class AuthRepository {
  Future<UserSession> login(String username, String password);
  Future<UserSession> refresh();
  Future<bool> logout();
}

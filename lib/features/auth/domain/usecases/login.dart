import 'package:interview_test/features/auth/domain/entities/user_session.dart';
import 'package:interview_test/features/auth/domain/repositories/auth_repository.dart';

class Login {
  final AuthRepository _authRepository;

  Login(this._authRepository);

  Future<UserSession> execute(String username, String password) async {
    return await _authRepository.login(username, password);
  }
}

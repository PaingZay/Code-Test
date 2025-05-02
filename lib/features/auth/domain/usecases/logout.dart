import 'package:interview_test/features/auth/domain/repositories/auth_repository.dart';

class Logout {
  final AuthRepository _authRepository;

  Logout(this._authRepository);

  Future<bool> execute() async {
    return await _authRepository.logout();
  }
}

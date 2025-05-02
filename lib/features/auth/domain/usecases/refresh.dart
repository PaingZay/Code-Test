import 'package:interview_test/features/auth/domain/entities/user_session.dart';
import 'package:interview_test/features/auth/domain/repositories/auth_repository.dart';

class Refresh {
  final AuthRepository _authRepository;

  Refresh(this._authRepository);

  Future<UserSession> execute() async {
    return await _authRepository.refresh();
  }
}

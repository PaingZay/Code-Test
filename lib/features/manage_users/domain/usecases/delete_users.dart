import 'package:interview_test/core/result_types.dart';
import 'package:interview_test/features/manage_users/domain/repositories/user_repository.dart';

import '../../../../core/usecases/usecase.dart';

class DeleteUsers implements UseCase<void, String> {
  final UserRepository repository;

  DeleteUsers(this.repository);

  @override
  Future<Result<void>> execute(String id) async {
    return await repository.deleteUser(id: id);
  }
}

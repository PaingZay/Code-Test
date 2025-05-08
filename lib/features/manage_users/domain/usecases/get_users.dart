import 'package:interview_test/core/result_types.dart';
import 'package:interview_test/features/manage_users/domain/repositories/user_repository.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';

class GetUsers implements UseCase<List<User>, NoParams> {
  final UserRepository repository;

  GetUsers(this.repository);

  @override
  Future<Result<List<User>>> execute(NoParams params) async {
    return await repository.getUsers();
  }
}

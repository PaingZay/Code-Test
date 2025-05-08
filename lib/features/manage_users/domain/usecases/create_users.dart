import 'package:interview_test/core/result_types.dart';
import 'package:interview_test/core/usecases/usecase.dart';
import 'package:interview_test/features/manage_users/domain/repositories/user_repository.dart';

class CreateUsers implements UseCase<void, CreateUserParams> {
  final UserRepository repository;

  CreateUsers(this.repository);

  @override
  Future<Result<void>> execute(CreateUserParams params) async {
    return await repository.createUser(name: params.name, email: params.email);
  }
}

class CreateUserParams {
  final String name;
  final String email;

  CreateUserParams({required this.name, required this.email});
}

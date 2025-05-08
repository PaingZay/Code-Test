import 'package:interview_test/core/result_types.dart';
import 'package:interview_test/core/usecases/usecase.dart';
import 'package:interview_test/features/manage_users/domain/repositories/user_repository.dart';

class UpdateUsers implements UseCase<void, UpdateUserParams> {
  final UserRepository repository;

  UpdateUsers(this.repository);

  @override
  Future<Result<void>> execute(UpdateUserParams params) async {
    return await repository.updateUser(
      id: params.id,
      name: params.name,
      email: params.email,
    );
  }
}

class UpdateUserParams {
  final String id;
  final String name;
  final String email;

  UpdateUserParams({required this.id, required this.name, required this.email});
}

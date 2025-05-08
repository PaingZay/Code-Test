import 'package:interview_test/core/result_types.dart';
import 'package:interview_test/features/manage_users/domain/entities/user.dart';

abstract interface class UserRepository {
  Future<Result<List<User>>> getUsers();
  Future<Result<void>> createUser({
    required String name,
    required String email,
  });
  Future<Result<void>> updateUser({
    required String id,
    required String name,
    required String email,
  });
  Future<Result<void>> deleteUser({required String id});
}

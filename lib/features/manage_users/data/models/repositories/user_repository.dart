import 'package:interview_test/core/exceptions.dart';
import 'package:interview_test/core/result_types.dart';
import 'package:interview_test/features/manage_users/data/datasources/user_remote_data_source.dart';
import 'package:interview_test/features/manage_users/data/models/user_model.dart';
import 'package:interview_test/features/manage_users/domain/entities/user.dart';
import 'package:interview_test/features/manage_users/domain/repositories/user_repository.dart';
import 'package:uuid/uuid.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<List<User>>> getUsers() async {
    return remoteDataSource.getUsers();
  }

  @override
  Future<Result<User>> createUser({
    required String name,
    required String email,
  }) async {
    UserModel user = UserModel(id: const Uuid().v1(), name: name, email: email);
    final result = await remoteDataSource.createUser(user);
    return result;
  }

  @override
  Future<Result<User>> updateUser({
    required String id,
    required String name,
    required String email,
  }) async {
    UserModel user = UserModel(id: id, name: name, email: email);
    final result = await remoteDataSource.updateUser(user);
    return result;
  }

  @override
  Future<Result<User>> deleteUser({required String id}) async {
    try {
      final result = await remoteDataSource.deleteUser(id);
      return result;
    } catch (e) {
      return Failure(ServerException());
    }
  }
}

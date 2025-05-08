import 'package:interview_test/core/constants/constants.dart';
import 'package:interview_test/core/exceptions.dart';
import 'package:interview_test/core/network.dart';
import 'package:interview_test/core/result_types.dart';
import 'package:interview_test/features/manage_users/data/datasources/user_remote_data_source.dart';
import 'package:interview_test/features/manage_users/data/models/user_model.dart';
import 'package:interview_test/features/manage_users/domain/entities/user.dart';
import 'package:interview_test/features/manage_users/domain/repositories/user_repository.dart';
import 'package:uuid/uuid.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Result<List<User>>> getUsers() async {
    if (!await (connectionChecker.isConnected)) {
      return (Failure(Exception(Constants.noConnectionErrorMessage)));
    }
    try {
      return remoteDataSource.getUsers();
    } on ServerException catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<User>> createUser({
    required String name,
    required String email,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return (Failure(Exception(Constants.noConnectionErrorMessage)));
      }
      UserModel user = UserModel(
        id: const Uuid().v1(),
        name: name,
        email: email,
      );
      final result = await remoteDataSource.createUser(user);
      return result;
    } on ServerException catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<User>> updateUser({
    required String id,
    required String name,
    required String email,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return (Failure(Exception(Constants.noConnectionErrorMessage)));
      }
      UserModel user = UserModel(id: id, name: name, email: email);
      final result = await remoteDataSource.updateUser(user);
      return result;
    } on ServerException catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<User>> deleteUser({required String id}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return (Failure(Exception(Constants.noConnectionErrorMessage)));
      }
      final result = await remoteDataSource.deleteUser(id);
      return result;
    } on ServerException catch (e) {
      return Failure(e);
    }
  }
}

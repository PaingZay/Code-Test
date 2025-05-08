import 'dart:convert';

import 'package:interview_test/core/enums/enum.dart';
import 'package:interview_test/core/exceptions.dart';
import 'package:interview_test/core/network/api_service.dart';
import 'package:interview_test/core/result_types.dart';
import 'package:interview_test/features/manage_users/data/models/user_model.dart';
import 'package:interview_test/features/manage_users/domain/entities/user.dart';

class UserRemoteDataSource {
  final ApiService apiService;
  final String baseUrl =
      "https://crudcrud.com/api/1c3f6d174fc849539f6d09490a191fc7/users";

  UserRemoteDataSource({required this.apiService});

  Future<Result<List<UserModel>>> getUsers() async {
    try {
      final response = await apiService.apiCall(
        url: baseUrl,
        method: HttpMethod.GET,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final List<UserModel> users =
            jsonList.map((json) => UserModel.fromJson(json)).toList();

        return Success(users);
      } else {
        return Failure(
          ServerException(
            ServerException("Internal Server Error: ${response.statusCode}")
                as String,
          ),
        );
      }
    } catch (e) {
      return Failure(
        ServerException(ServerException("Failed to fetch users: $e") as String),
      );
    }
  }

  Future<Result<User>> createUser(UserModel user) async {
    try {
      final response = await apiService.apiCall(
        url: baseUrl,
        method: HttpMethod.POST,
        body: user.toJson(),
      );

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(json.decode(response.body));
        return Success(user);
      } else {
        return Failure(
          ServerException(
            "Failed to create user: Server responded with ${response.statusCode}",
          ),
        );
      }
    } catch (e) {
      return Failure(ServerException("Error creating user: $e"));
    }
  }

  Future<Result<User>> updateUser(UserModel user) async {
    try {
      final response = await apiService.apiCall(
        url: "$baseUrl/${user.id}",
        method: HttpMethod.PUT,
        body: user.toJson(),
      );

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(json.decode(response.body));
        return Success(user);
      } else {
        return Failure(
          ServerException(
            "Failed to update user: Server responded with ${response.statusCode}",
          ),
        );
      }
    } catch (e) {
      return Failure(ServerException("Error updating user: $e"));
    }
  }

  Future<Result<User>> deleteUser(String id) async {
    try {
      final response = await apiService.apiCall(
        url: "$baseUrl/$id",
        method: HttpMethod.DELETE,
      );

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(json.decode(response.body));
        return Success(user);
      } else {
        return Failure(
          ServerException(
            "Failed to delete user: Server responded with ${response.statusCode}",
          ),
        );
      }
    } catch (e) {
      return Failure(ServerException("Error deleting user: $e"));
    }
  }
}

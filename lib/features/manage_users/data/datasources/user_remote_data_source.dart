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
      "https://crudcrud.com/api/b29972957da749ca88658377431c4b41/users";

  UserRemoteDataSource({required this.apiService});

  Future<Result<List<UserModel>>> getUsers() async {
    try {
      final response = await apiService.apiCall(
        url: baseUrl,
        method: HttpMethod.GET,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
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
      throw ServerException(e.toString());
    }
  }

  Future<Result<User>> createUser(UserModel user) async {
    try {
      final response = await apiService.apiCall(
        url: baseUrl,
        method: HttpMethod.POST,
        body: user.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
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
      throw ServerException(e.toString());
    }
  }

  Future<Result<User>> updateUser(UserModel user) async {
    try {
      final response = await apiService.apiCall(
        url: "$baseUrl/${user.id}",
        method: HttpMethod.PUT,
        body: user.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
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
      throw ServerException(e.toString());
    }
  }

  Future<Result<User>> deleteUser(String id) async {
    try {
      final response = await apiService.apiCall(
        url: "$baseUrl/$id",
        method: HttpMethod.DELETE,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
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
      throw ServerException(e.toString());
    }
  }
}

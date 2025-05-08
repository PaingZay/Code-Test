import 'package:interview_test/features/manage_users/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.name, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['_id'], name: json['name'], email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email};
  }
}

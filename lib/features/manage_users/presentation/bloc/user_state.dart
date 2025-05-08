import 'package:interview_test/features/manage_users/domain/entities/user.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<User> users;
  UsersLoaded(this.users);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}

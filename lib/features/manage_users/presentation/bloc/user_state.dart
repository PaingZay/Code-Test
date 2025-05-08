import 'package:interview_test/features/manage_users/domain/entities/user.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<User> users;
  final String message;
  UsersLoaded(this.users, this.message);
}

class UserCreated extends UserState {
  final String message;
  UserCreated(this.message);
}

class UserUpdated extends UserState {
  final String message;
  UserUpdated(this.message);
}

class UserDeleted extends UserState {
  final String message;
  UserDeleted(this.message);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}

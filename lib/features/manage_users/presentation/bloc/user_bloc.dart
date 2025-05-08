import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_test/core/result_types.dart';
import 'package:interview_test/core/usecases/usecase.dart';
import 'package:interview_test/features/manage_users/domain/entities/user.dart';
import 'package:interview_test/features/manage_users/domain/usecases/create_users.dart';
import 'package:interview_test/features/manage_users/domain/usecases/delete_users.dart';
import 'package:interview_test/features/manage_users/domain/usecases/get_users.dart';
import 'package:interview_test/features/manage_users/domain/usecases/update_user.dart';
import 'package:interview_test/features/manage_users/presentation/bloc/user_event.dart';
import 'package:interview_test/features/manage_users/presentation/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsers getUsers;
  final CreateUsers createUser;
  final UpdateUsers updateUser;
  final DeleteUsers deleteUser;

  UserBloc({
    required this.getUsers,
    required this.createUser,
    required this.updateUser,
    required this.deleteUser,
  }) : super(UserInitial()) {
    on<LoadUsers>(_onLoadUsers);
    on<CreateUser>(_onCreateUser);
    on<UpdateUser>(_onUpdateUser);
    on<DeleteUser>(_onDeleteUser);
  }

  Future<void> _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await getUsers.execute(NoParams());

    final value = switch (result) {
      Success<List<User>>(value: final users) => UsersLoaded(
        users,
        "Users loaded successfully",
      ),
      Failure<List<User>>(exception: final exception) => UserError(
        exception.toString(),
      ),
    };
    emit(value);
  }

  Future<void> _onCreateUser(CreateUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await createUser.execute(
      CreateUserParams(name: event.user.name, email: event.user.email),
    );

    final value = switch (result) {
      Success<void>(value: _) => UserCreated("User created successfully"),
      Failure<void>(exception: final exception) => UserError(
        exception.toString(),
      ),
    };

    emit(value);
    add(LoadUsers());
  }

  Future<void> _onDeleteUser(DeleteUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await deleteUser.execute(event.userId);

    final value = switch (result) {
      Success<void>(value: _) => UserDeleted("User deleted successfully"),
      Failure<void>(exception: final exception) => UserError(
        exception.toString(),
      ),
    };

    emit(value);
    add(LoadUsers());
  }

  Future<void> _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await updateUser.execute(
      UpdateUserParams(
        id: event.user.id,
        name: event.user.name,
        email: event.user.email,
      ),
    );
    final value = switch (result) {
      Success<void>(value: _) => UserUpdated("User deleted successfully"),
      Failure<void>(exception: final exception) => UserError(
        exception.toString(),
      ),
    };
    emit(value);
    add(LoadUsers());
  }
}

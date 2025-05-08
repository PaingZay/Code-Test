import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:interview_test/core/network.dart';
import 'package:interview_test/core/network/api_service.dart';
import 'package:interview_test/features/manage_users/data/datasources/user_remote_data_source.dart';
import 'package:interview_test/features/manage_users/data/models/repositories/user_repository_impl.dart';
import 'package:interview_test/features/manage_users/domain/repositories/user_repository.dart';
import 'package:interview_test/features/manage_users/domain/usecases/create_users.dart';
import 'package:interview_test/features/manage_users/domain/usecases/delete_users.dart';
import 'package:interview_test/features/manage_users/domain/usecases/get_users.dart';
import 'package:interview_test/features/manage_users/domain/usecases/update_user.dart';
import 'package:interview_test/features/manage_users/presentation/bloc/user_bloc.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  final GetIt locator = GetIt.instance;
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton<Connectivity>(() => Connectivity());

  locator.registerLazySingleton<ConnectionChecker>(
    () => ConnectionCheckerImpl(locator()),
  );
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: locator(),
      connectionChecker: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => UserRemoteDataSource(apiService: locator<ApiService>()),
  );
  locator.registerLazySingleton(() => GetUsers(locator<UserRepository>()));
  locator.registerLazySingleton(() => CreateUsers(locator<UserRepository>()));
  locator.registerLazySingleton(() => UpdateUsers(locator<UserRepository>()));
  locator.registerLazySingleton(() => DeleteUsers(locator<UserRepository>()));
  locator.registerFactory(
    () => UserBloc(
      getUsers: locator(),
      createUser: locator(),
      updateUser: locator(),
      deleteUser: locator(),
    ),
  );
}

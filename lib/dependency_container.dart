import 'package:get_it/get_it.dart';
import 'package:interview_test/core/api_service.dart';
import 'package:interview_test/features/auth/data/datasources/auth_data_source.dart';
import 'package:interview_test/features/auth/data/repositories/auth_repository.dart';
import 'package:interview_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:interview_test/features/auth/domain/usecases/login.dart';
import 'package:interview_test/features/auth/domain/usecases/logout.dart';
import 'package:interview_test/features/auth/domain/usecases/refresh.dart';
import 'package:interview_test/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:interview_test/features/home/data/datasources/pickup_datasouce.dart';
import 'package:interview_test/features/home/data/repositories/pickup_repository.dart';
import 'package:interview_test/features/home/domain/repositories/pickup_repository.dart';
import 'package:interview_test/features/home/domain/usecases/get_pickup_list.dart';
import 'package:interview_test/features/home/presentation/viewmodels/pickup_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  final GetIt locator = GetIt.instance;
  locator.registerLazySingleton(() => FlutterSecureStorage());

  locator.registerLazySingleton(() => Refresh(locator<AuthRepository>()));

  locator.registerLazySingleton(() => Logout(locator<AuthRepository>()));

  locator.registerLazySingleton(() => ApiService());

  locator.registerLazySingleton(() => AuthDataSource(locator<ApiService>()));

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      dataSource: locator(),
      storage: locator<FlutterSecureStorage>(),
    ),
  );

  locator.registerLazySingleton(() => Login(locator<AuthRepository>()));

  locator.registerFactory(
    () =>
        AuthViewModel(locator<Login>(), locator<Refresh>(), locator<Logout>()),
  );

  locator.registerLazySingleton(
    () => GetPickupList(locator<PickupRepository>()),
  );

  locator.registerFactory(
    () => PickupViewModel(
      locator<GetPickupList>(),
      locator<Refresh>(),
      locator<Logout>(),
    ),
  );

  locator.registerLazySingleton<PickupRepository>(
    () => PickupRepositoryImpl(
      dataSource: locator(),
      storage: locator<FlutterSecureStorage>(),
    ),
  );

  locator.registerLazySingleton(() => PickupDataSource(locator<ApiService>()));

  locator.registerSingletonAsync<SharedPreferences>(
    () async => SharedPreferences.getInstance(),
  );
}

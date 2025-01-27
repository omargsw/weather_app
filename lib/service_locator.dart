part of 'service_locator_imports.dart';

class ServiceLocator {
  const ServiceLocator._();
  static final inject = GetIt.instance;

  /// Initialize service locator
  static Future<void> init() async {
    await core();
    await external();
    await initFeatures();
  }

  /// Initialize Core
  static Future<void> core() async {
    /// Core dependencies
    inject.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(connectionChecker: inject()));
  }

  /// Initialize External
  static Future<void> external() async {
    inject.registerLazySingleton(() => InternetConnection());
  }

  ///Initialize Features
  static Future<void> initFeatures() async {
    await authFeature();
    await userFeature();
  }

  static Future<void> authFeature() async {
    /// Presentation Layer
    // * Bloc
    inject.registerFactory(() => RegisterBloc(registerUsecase: inject()));
    inject.registerFactory(() => LoginBloc(loginUsecase: inject()));

    /// Domain Layer
    // * Use cases
    inject
        .registerLazySingleton(() => RegisterUsecase(authRepository: inject()));
    inject.registerLazySingleton(() => LoginUsecase(authRepository: inject()));

    // * Repositories
    inject.registerLazySingleton<AuthRepository>(() =>
        AuthRepository(authRemoteDataSource: inject(), networkInfo: inject()));

    /// Data Layer
    // * Remote Data Source
    inject.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSource());
  }

  static Future<void> userFeature() async {
    /// Presentation Layer
    // * Bloc
    inject.registerFactory(() => UserInfoBloc(userInfoRepository: inject()));

    /// Domain Layer
    // * Use cases
    inject.registerLazySingleton(
        () => FetchUserInfoUsecase(userInfoRepository: inject()));

    // * Repositories
    inject.registerLazySingleton<UserInfoRepository>(() => UserInfoRepository(
        userInfoRemoteDataSource: inject(), networkInfo: inject()));

    /// Data Layer
    // * Remote Data Source
    inject.registerLazySingleton<UserInfoRemoteDataSource>(
        () => UserInfoRemoteDataSource());
  }
}

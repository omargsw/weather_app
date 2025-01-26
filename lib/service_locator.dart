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
    /// External dependencies
    inject.registerLazySingleton(() => InternetConnection());
  }

  ///Initialize Features
  static Future<void> initFeatures() async {
    await registerFeature();
    await authFeature();
    // Add features here ....
  }

  static Future<void> authFeature() async {
    /// Presentation Layer
    // * Bloc
    // inject.registerFactory(() => AuthBloc(sendOtpUsecase: inject()));

    /// Domain Layer
    // * Use cases
    inject.registerLazySingleton(
        () => RegisterUsecase(registerRepository: inject()));

    // * Repositories
    inject.registerLazySingleton<RegisterRepository>(() => RegisterRepository(
        registerRemoteDataSource: inject(), networkInfo: inject()));

    /// Data Layer
    // * Remote Data Source
    inject.registerLazySingleton<RegisterRemoteDataSource>(
        () => RegisterRemoteDataSource());
  }

  static Future<void> registerFeature() async {
    /// Presentation Layer
    // * Bloc
    inject.registerFactory(() => RegisterBloc(registerUsecase: inject()));
  }
}

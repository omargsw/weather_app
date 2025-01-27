part of 'routes_generator_imports.dart';

Route? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splashScreen:
      return AppPageRoute(
        builder: (context) => const SplashScreen(),
      );

    case AppRoutes.homeScreen:
      return AppPageRoute(builder: (context) => HomeScreen());

    case AppRoutes.registerScreen:
      return AppPageRoute(builder: (context) => RegisterScreen());
    case AppRoutes.loginScreen:
      return AppPageRoute(builder: (context) => LoginScreen());
    // case AppRoutes.registerScreen:
    //   return AppPageRoute(builder: (context) => RegisterScreen());
    // case AppRoutes.registerScreen:
    //   return AppPageRoute(builder: (context) => RegisterScreen());

    default:
      return AppPageRoute(
        builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text(
                AppStrings.undefinedRoute,
              ),
            ),
          );
        },
      );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/app/config/themes/dark_theme.dart';
import 'package:weather_app/app/config/themes/light_theme.dart';
import 'package:weather_app/core/utils/helpers/app_strings.dart';

import 'config/routing/app_router.dart';
import 'config/routing/navigator_observer.dart';
import 'config/routing/routes_generator_imports.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    ///TODO : Add design size
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ar'), Locale('en')],

          ///TODO : implement localization
          locale: const Locale('en'),
          theme: lightTheme(),
          darkTheme: darkTheme(),
          onGenerateRoute: onGenerateRoute,
          navigatorObservers: [MyObserver()],
          initialRoute: AppRoutes.splashScreen,
        );
      },
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/app/config/themes/dark_theme.dart';
import 'package:weather_app/app/config/themes/light_theme.dart';
import 'package:weather_app/core/utils/helpers/app_strings.dart';
import 'package:weather_app/features/home/presentation/bloc/cubit/theme_cubit.dart';

import 'config/routing/app_router.dart';
import 'config/routing/navigator_observer.dart';
import 'config/routing/routes_generator_imports.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      builder: (context, child) {
        return BlocProvider(
          create: (_) => ThemeCubit(),
          child: BlocBuilder<ThemeCubit, bool>(
            builder: (context, isDarkTheme) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: AppStrings.appName,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                theme: lightTheme(),
                darkTheme: darkTheme(),
                themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
                onGenerateRoute: onGenerateRoute,
                navigatorObservers: [MyObserver()],
                initialRoute: AppRoutes.splashScreen,
              );
            },
          ),
        );
      },
    );
  }
}

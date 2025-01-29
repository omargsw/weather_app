// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/app/config/routing/app_router.dart';
import 'package:weather_app/core/components/error_handler.dart';
import 'package:weather_app/core/locale/app_languages.dart';
import 'package:weather_app/core/utils/helpers/app_strings.dart';
import 'package:weather_app/features/home/presentation/bloc/cubit/theme_cubit.dart';
import 'package:weather_app/features/home/presentation/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:weather_app/features/home/presentation/components/user_info_header.dart';
import 'package:weather_app/service_locator_imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String selectedLanguage =
        context.locale.languageCode == 'ar' ? 'Arabic' : 'English';
    return PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(),
          body: BlocProvider(
            create: (context) => ServiceLocator.inject<UserInfoBloc>()
              ..add(FetchUserInfoEvent()),
            child: BlocBuilder<UserInfoBloc, UserInfoState>(
              builder: (context, state) {
                final bloc = context.read<UserInfoBloc>();
                if (state is LoadingUserInfoState) {
                  return Center(child: CircularProgressIndicator.adaptive());
                } else if (state is ErrorUserInfoState) {
                  return ErrorHandler(
                    message: state.message,
                    errorCode: state.errorCode,
                    onPressed: () => bloc.add(FetchUserInfoEvent()),
                  );
                } else if (state is LoadedUserInfoState) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserInfoHeader(userEmail: state.userInfo.email),
                          Gap(100),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.weatherScreen);
                            },
                            child: Text(AppStrings.weather.tr()),
                          ),
                          Gap(20),
                          ElevatedButton(
                            onPressed: () async {
                              if (selectedLanguage == 'English') {
                                await context
                                    .setLocale(const Locale('ar', 'SA'));
                              } else {
                                await context
                                    .setLocale(const Locale('en', 'US'));
                              }
                              LanguageChanging().changeAppLanguage();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  AppRoutes.homeScreen, (route) => false);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 10,
                              children: [
                                Text(
                                  AppStrings.lang.tr(),
                                ),
                                Icon(
                                  Icons.language,
                                  color:
                                      BlocProvider.of<ThemeCubit>(context).state
                                          ? Colors.black
                                          : Colors.white,
                                ),
                              ],
                            ),
                          ),
                          Gap(20),
                          ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<ThemeCubit>(context)
                                  .toggleTheme();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 10,
                              children: [
                                Text(BlocProvider.of<ThemeCubit>(context).state
                                    ? AppStrings.dark.tr()
                                    : AppStrings.light.tr()),
                                Icon(
                                  BlocProvider.of<ThemeCubit>(context).state
                                      ? Icons.dark_mode
                                      : Icons.light_mode,
                                  color:
                                      BlocProvider.of<ThemeCubit>(context).state
                                          ? Colors.black
                                          : Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator.adaptive());
              },
            ),
          ),
        ));
  }
}

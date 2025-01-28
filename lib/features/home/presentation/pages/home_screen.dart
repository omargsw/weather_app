// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/app/config/routing/app_router.dart';
import 'package:weather_app/core/components/error_handler.dart';
import 'package:weather_app/core/styles/app_colors.dart';
import 'package:weather_app/core/styles/app_text_style.dart';
import 'package:weather_app/core/utils/helpers/app_cache.dart';
import 'package:weather_app/core/utils/helpers/app_constants.dart';
import 'package:weather_app/core/utils/helpers/app_strings.dart';
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
  String userID = '';

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
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: AppColors.primary,
            onPressed: () async {
              if (selectedLanguage == 'English') {
                await context.setLocale(const Locale('ar', 'SA'));
                AppCache.saveData(key: AppConstants.chosenLang, value: 'ar');
              } else {
                await context.setLocale(const Locale('en', 'US'));
                AppCache.saveData(key: AppConstants.chosenLang, value: 'en');
              }
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.homeScreen, (route) => false);
            },
            icon: const Icon(
              Icons.language,
              color: AppColors.white,
            ),
            label: Text(
              AppStrings.lang.tr(),
              style: mediumStyle(fontSize: 16, color: AppColors.white),
            ),
          ),
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
                          )
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

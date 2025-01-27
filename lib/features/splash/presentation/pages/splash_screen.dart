import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/core/images/app_images.dart';
import 'package:weather_app/core/styles/app_colors.dart';
import 'package:weather_app/core/styles/app_text_style.dart';
import 'package:weather_app/features/splash/presentation/bloc/splash_bloc.dart';

import '../../../../app/config/routing/app_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(SplashStartedEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashFinishedState) {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.homeScreen, (route) => false);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(AppImages.splashLogo),
                ),
              ),
              Text(
                "© 2025 Omar Wathaifi",
                style: mediumStyle(fontSize: 14),
              ),
              Gap(30),
            ],
          ),
        ),
      ),
    );
  }
}

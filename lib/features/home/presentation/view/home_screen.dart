import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/core/components/error_handler.dart';
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
    return PopScope(
      canPop: false,
      child: BlocProvider(
        create: (context) =>
            ServiceLocator.inject<UserInfoBloc>()..add(FetchUserInfoEvent()),
        child: BlocBuilder<UserInfoBloc, UserInfoState>(
          builder: (context, state) {
            final bloc = context.read<UserInfoBloc>();
            if (state is LoadingUserInfoState) {
              return Scaffold(
                  body: Center(child: CircularProgressIndicator.adaptive()));
            } else if (state is ErrorUserInfoState) {
              return ErrorHandler(
                message: state.message,
                errorCode: state.errorCode,
                onPressed: () => bloc.add(FetchUserInfoEvent()),
              );
            } else if (state is LoadedUserInfoState) {
              return Scaffold(
                appBar: AppBar(),
                body: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserInfoHeader(userEmail: state.userInfo.email),
                        Gap(100),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(AppStrings.weather.tr()),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return Scaffold(
                body: Center(child: CircularProgressIndicator.adaptive()));
          },
        ),
      ),
    );
  }
}

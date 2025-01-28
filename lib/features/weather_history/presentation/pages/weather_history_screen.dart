import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/core/components/error_handler.dart';
import 'package:weather_app/core/styles/app_text_style.dart';
import 'package:weather_app/core/utils/helpers/app_strings.dart';
import 'package:weather_app/features/weather_history/presentation/bloc/weather_history_bloc.dart';
import 'package:weather_app/features/weather_history/presentation/components/history_card.dart';
import 'package:weather_app/service_locator_imports.dart';

class WeatherHistoryScreen extends StatefulWidget {
  const WeatherHistoryScreen({super.key});

  @override
  State<WeatherHistoryScreen> createState() => _WeatherHistoryScreenState();
}

class _WeatherHistoryScreenState extends State<WeatherHistoryScreen>
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
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.weatherHistory.tr()),
      ),
      body: BlocProvider(
        create: (context) => ServiceLocator.inject<WeatherHistoryBloc>()
          ..add(FetchWeatherHistoryEvent()),
        child: BlocBuilder<WeatherHistoryBloc, WeatherHistoryState>(
          builder: (context, state) {
            final bloc = context.read<WeatherHistoryBloc>();
            if (state is WeatherHistoryLoadingState) {
              return Center(child: CircularProgressIndicator.adaptive());
            } else if (state is WeatherHistoryErrorState) {
              return ErrorHandler(
                message: state.message,
                errorCode: state.errorCode,
                onPressed: () => bloc.add(FetchWeatherHistoryEvent()),
              );
            } else if (state is WeatherHistoryLoadedState) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: state.weatherHistory.isEmpty
                    ? Center(
                        child: Text(
                        AppStrings.noHistory.tr(),
                        style: mediumStyle(fontSize: 16, color: Colors.grey),
                      ))
                    : ListView.separated(
                        separatorBuilder: (context, index) => Gap(10),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 16),
                        itemCount: state.weatherHistory.length,
                        itemBuilder: (context, index) {
                          final data = state.weatherHistory[index];
                          return GestureDetector(
                              onTap: () {
                                Navigator.pop(context, data.city);
                              },
                              child: HistoryCard(data: data));
                        },
                      ),
              );
            }
            return Center(child: CircularProgressIndicator.adaptive());
          },
        ),
      ),
    );
  }
}

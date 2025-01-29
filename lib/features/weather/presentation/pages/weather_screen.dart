import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/app/config/routing/app_router.dart';
import 'package:weather_app/core/components/custom_text_form_field.dart';
import 'package:weather_app/core/components/error_handler.dart';
import 'package:weather_app/core/styles/app_colors.dart';
import 'package:weather_app/core/styles/app_text_style.dart';
import 'package:weather_app/core/utils/helpers/app_functions.dart';
import 'package:weather_app/core/utils/helpers/app_input_formatter.dart';
import 'package:weather_app/core/utils/helpers/app_strings.dart';
import 'package:weather_app/core/utils/helpers/app_validator.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/service_locator_imports.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool isCelsius = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.weather.tr()),
      ),
      body: BlocProvider(
        create: (context) => ServiceLocator.inject<WeatherBloc>(),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            final bloc = context.read<WeatherBloc>();
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Form(
                      key: bloc.formKey,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: CustomTextFormField(
                          controller: bloc.cityNameController,
                          hintText: AppStrings.enterCityName.tr(),
                          keyboardType: TextInputType.name,
                          inputFormatters: [AppInputFormatter.nameFormatter()],
                          validator: AppValidator.validateName,
                        ),
                      ),
                    ),
                    Gap(16),
                    ElevatedButton(
                      onPressed: () {
                        if (bloc.formKey.currentState!.validate()) {
                          AppFunctions.unFocusKeyboard(context);
                          bloc.add(FetchWeatherEvent(
                              cityName: bloc.cityNameController.text));
                        }
                      },
                      child: Text(AppStrings.fetchWeather.tr()),
                    ),
                    Gap(16),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.transparent),
                        side: WidgetStateProperty.all(
                            BorderSide(color: AppColors.primary, width: 2)),
                      ),
                      onPressed: () {
                        AppFunctions.unFocusKeyboard(context);
                        Navigator.pushNamed(
                                context, AppRoutes.weatherHistoryScreen)
                            .then((value) {
                          if (value != null) {
                            if (value is String) {
                              bloc.add(FetchWeatherEvent(cityName: value));
                            }
                          }
                        });
                      },
                      child: Text(
                        AppStrings.weatherHistory.tr(),
                        style: boldStyle(
                          fontSize: 16.sp,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    Gap(100),
                    if (state is WeatherLoadingState)
                      Center(
                        child: CircularProgressIndicator(),
                      )
                    else if (state is WeatherErrorState)
                      ErrorHandler(
                        message: state.message,
                        errorCode: state.errorCode,
                        onPressed: () => bloc.add(FetchWeatherEvent(
                            cityName: bloc.cityNameController.text)),
                      )
                    else if (state is WeatherLoadedState)
                      FadeTransition(
                        opacity: AlwaysStoppedAnimation(1.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${state.weatherData.name}, ${state.weatherData.sys!.country}',
                              style: boldStyle(fontSize: 24),
                            ),
                            Gap(10),
                            Text(
                              '${convertTemperature(state.weatherData.main!.temp).toStringAsFixed(1)}°${isCelsius ? 'C' : 'F'}',
                              style: boldStyle(fontSize: 30),
                            ),
                            Gap(10),
                            Text(
                              '${AppStrings.windSpeed.tr()}: ${state.weatherData.wind!.speed} ${AppStrings.ms.tr()}',
                              style: boldStyle(fontSize: 18),
                            ),
                            Text(
                              '${AppStrings.humidity.tr()}: ${state.weatherData.main!.humidity}%',
                              style: boldStyle(fontSize: 18),
                            ),
                            Gap(10),
                            if (state.weatherData.weather.isNotEmpty) ...[
                              Text(
                                state.weatherData.weather.first.main,
                                style: mediumStyle(
                                    fontSize: 18, color: Colors.grey),
                              ),
                              Text(
                                state.weatherData.weather.first.description,
                                style: mediumStyle(
                                    fontSize: 18, color: Colors.grey),
                              ),
                            ],
                            Gap(10),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isCelsius = !isCelsius;
                                  });
                                },
                                child: Text(
                                  '${AppStrings.switchTo.tr()} ${isCelsius ? AppStrings.fahrenheit.tr() : AppStrings.celsius.tr()}',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  double convertTemperature(double temp) {
    return isCelsius ? temp : (temp * 9 / 5) + 32;
  }
}

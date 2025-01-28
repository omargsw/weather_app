import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/utils/helpers/app_constants.dart';
import 'package:weather_app/core/utils/helpers/app_functions.dart';
import 'package:weather_app/core/utils/helpers/app_secure_storage.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/usecases/fetch_weather_usercase.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  TextEditingController cityNameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FetchWeatherUsecase fetchWeatherUsecase;
  WeatherBloc({required this.fetchWeatherUsecase}) : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {
      if (event is FetchWeatherEvent) {
        emit(WeatherLoadingState());
        final weatherData =
            await fetchWeatherUsecase.call(cityName: event.cityName);
        weatherData.fold(
          (failure) {
            final String errorMessage =
                AppFunctions.mapFailureToMessage(failure: failure);
            String? errorCode;
            if (failure is ServerFailure) {
              errorCode = failure.errorCode;
            }
            log(errorMessage, name: "errorMessage");
            log(errorCode ?? "no error code", name: "errorCode");
            emit(
                WeatherErrorState(message: errorMessage, errorCode: errorCode));
          },
          (weather) async {
            saveWeatherToFirestore(weather);
            emit(
              WeatherLoadedState(weatherData: weather),
            );
          },
        );
      }
    });
  }

  Future<void> saveWeatherToFirestore(WeatherModel weather) async {
    try {
      String uuid =
          await AppSecureStorage.getData(key: AppConstants.userID) ?? "";
      if (uuid.isEmpty) return;

      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final CollectionReference historyCollection =
          firestore.collection("users").doc(uuid).collection("history");

      final Timestamp timestamp = Timestamp.now();

      final Map<String, dynamic> weatherEntry = {
        "city": weather.name,
        "country": weather.sys!.country,
        "windSpeed": weather.wind!.speed,
        "humidity": weather.main!.humidity,
        "temp": weather.main!.temp,
        "weatherMain": weather.weather.first.main,
        "description": weather.weather.first.description,
        "timestamp": timestamp,
      };

      final QuerySnapshot snapshot =
          await historyCollection.where('city', isEqualTo: weather.name).get();

      if (snapshot.docs.isNotEmpty) {
        final docId = snapshot.docs.first.id;
        await historyCollection.doc(docId).update(weatherEntry);
        log("Weather data updated for city: ${weather.name}");
      } else {
        await historyCollection.add(weatherEntry);
        log("Weather data saved for new city: ${weather.name}");
      }
    } catch (e) {
      log("Error saving weather data to Firestore: $e");
    }
  }
}

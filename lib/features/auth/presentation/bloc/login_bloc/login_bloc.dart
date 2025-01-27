import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/utils/helpers/app_functions.dart';
import 'package:weather_app/features/auth/domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool obscurePass = true;

  final LoginUsecase loginUsecase;
  LoginBloc({required this.loginUsecase}) : super(LoginInitial()) {
    on<LoginEvent>(onLoginEvent);
  }

  void onLoginEvent(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is LoginnEvent) {
      emit(LoadingLoginState());
      final register = await loginUsecase.call(
        email: emailController.text,
        password: passController.text,
      );
      register.fold(
        (failure) {
          final String errorMessage =
              AppFunctions.mapFailureToMessage(failure: failure);

          String? errorCode;
          if (failure is ServerFailure) {
            errorCode = failure.errorCode;
          }
          log(errorMessage, name: "errorMessage");
          log(errorCode ?? "no error code", name: "errorCode");
          emit(ErrorLoginState(
              message: errorMessage, errorCode: errorCode ?? ""));
        },
        (uuid) {
          log(uuid);
          emit(SuccessLoginState(uuid: uuid));
        },
      );
    }
  }
}

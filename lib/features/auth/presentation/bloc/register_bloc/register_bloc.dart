import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/utils/helpers/app_functions.dart';

import '../../../domain/usecases/register_usercase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confPassController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool obscurePass = true;
  bool obscureConfPass = true;

  final RegisterUsecase registerUsecase;
  RegisterBloc({required this.registerUsecase}) : super(RegisterInitial()) {
    on<RegisterEvent>(onSignUpEvent);
  }

  void onSignUpEvent(RegisterEvent event, Emitter<RegisterState> emit) async {
    if (event is SignUpEvent) {
      emit(LoadingSignUpState());
      final register = await registerUsecase.call(
        email: event.email,
        password: event.confirmPassword,
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
          emit(ErrorSignUpState(
              message: errorMessage, errorCode: errorCode ?? ""));
        },
        (uuid) {
          log(uuid);
          emit(SuccessSignUpState(uuid: uuid));
        },
      );
    }
  }
}

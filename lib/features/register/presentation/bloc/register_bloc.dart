import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/register_usercase.dart';

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
    on<RegisterEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

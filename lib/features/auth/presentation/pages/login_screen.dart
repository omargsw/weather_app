import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/app/config/routing/app_router.dart';
import 'package:weather_app/core/components/custom_button.dart';
import 'package:weather_app/core/components/custom_text_form_field.dart';
import 'package:weather_app/core/images/app_images.dart';
import 'package:weather_app/core/styles/app_text_style.dart';
import 'package:weather_app/core/utils/helpers/app_constants.dart';
import 'package:weather_app/core/utils/helpers/app_functions.dart';
import 'package:weather_app/core/utils/helpers/app_logger.dart';
import 'package:weather_app/core/utils/helpers/app_secure_storage.dart';
import 'package:weather_app/core/utils/helpers/app_snackbar.dart';
import 'package:weather_app/core/utils/helpers/app_validator.dart';
import 'package:weather_app/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:weather_app/features/auth/presentation/pages/register_screen.dart';
import 'package:weather_app/service_locator_imports.dart';

import '../../../../core/utils/helpers/app_input_formatter.dart';
import '../../../../core/utils/helpers/app_strings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceLocator.inject<LoginBloc>(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is ErrorLoginState) {
            AppSnackBar.show(
                context: context,
                message: state.errorCode ?? AppStrings.unknownError.tr(),
                type: SnackBarType.error);
          } else if (state is SuccessLoginState) {
            final uuid = state.uuid;
            AppLogger.debug(uuid.toString());
            AppSecureStorage.saveData(key: AppConstants.userID, value: uuid);
            Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
          }
        },
        builder: (context, state) {
          final bloc = context.read<LoginBloc>();
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Form(
                  key: bloc.formKey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gap(150),
                      Image.asset(AppImages.splashLogo),
                      Gap(40),
                      Text(
                        AppStrings.login.tr(),
                        style: boldStyle(fontSize: 20),
                      ),
                      Gap(40),
                      CustomTextFormField(
                        controller: bloc.emailController,
                        hintText: AppStrings.email.tr(),
                        keyboardType: TextInputType.name,
                        inputFormatters: [AppInputFormatter.emailFormatter()],
                        validator: AppValidator.validateEmail,
                      ),
                      Gap(20),
                      CustomTextFormField(
                        controller: bloc.passController,
                        hintText: AppStrings.password.tr(),
                        keyboardType: TextInputType.name,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                bloc.obscurePass = !bloc.obscurePass;
                              });
                            },
                            icon: Icon(bloc.obscurePass
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.errorEmptyField.tr();
                          }
                          return null;
                        },
                        obscureText: bloc.obscurePass,
                      ),
                      Gap(60),
                      CustomButton(
                        title: AppStrings.login.tr(),
                        onPressed: () {
                          if (bloc.formKey.currentState!.validate()) {
                            AppFunctions.unFocusKeyboard(context);
                            bloc.add(LoginnEvent());
                          }
                        },
                        isLoading: state is LoadingLoginState,
                      ),
                      Gap(20),
                      LoginAndRegisterRichText(isLogin: true)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

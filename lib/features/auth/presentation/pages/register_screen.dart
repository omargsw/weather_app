import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/app/config/routing/app_router.dart';
import 'package:weather_app/core/components/custom_button.dart';
import 'package:weather_app/core/components/custom_text_form_field.dart';
import 'package:weather_app/core/images/app_images.dart';
import 'package:weather_app/core/styles/app_colors.dart';
import 'package:weather_app/core/styles/app_text_style.dart';
import 'package:weather_app/core/utils/helpers/app_constants.dart';
import 'package:weather_app/core/utils/helpers/app_functions.dart';
import 'package:weather_app/core/utils/helpers/app_logger.dart';
import 'package:weather_app/core/utils/helpers/app_secure_storage.dart';
import 'package:weather_app/core/utils/helpers/app_snackbar.dart';
import 'package:weather_app/core/utils/helpers/app_validator.dart';
import 'package:weather_app/features/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:weather_app/features/home/presentation/bloc/cubit/theme_cubit.dart';
import 'package:weather_app/service_locator_imports.dart';

import '../../../../core/utils/helpers/app_input_formatter.dart';
import '../../../../core/utils/helpers/app_strings.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceLocator.inject<RegisterBloc>(),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is ErrorSignUpState) {
            AppSnackBar.show(
                context: context,
                message: state.errorCode ?? AppStrings.unknownError.tr(),
                type: SnackBarType.error);
          } else if (state is SuccessSignUpState) {
            final uuid = state.uuid;
            AppLogger.debug(uuid.toString());
            AppSecureStorage.saveData(key: AppConstants.userID, value: uuid);
            Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
            AppSnackBar.show(
                context: context,
                message: AppStrings.accountRegisteredSuccessfully.tr(),
                type: SnackBarType.success);
          }
        },
        builder: (context, state) {
          final bloc = context.read<RegisterBloc>();
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
                        AppStrings.register.tr(),
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
                        inputFormatters: [
                          AppInputFormatter.emailFormatter(),
                        ],
                        validator: AppValidator.validatePassword,
                        obscureText: bloc.obscurePass,
                      ),
                      Gap(20),
                      CustomTextFormField(
                        controller: bloc.confPassController,
                        hintText: AppStrings.confirmPassword.tr(),
                        keyboardType: TextInputType.name,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                bloc.obscureConfPass = !bloc.obscureConfPass;
                              });
                            },
                            icon: Icon(bloc.obscureConfPass
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        inputFormatters: [
                          AppInputFormatter.emailFormatter(),
                        ],
                        validator: (value) =>
                            AppValidator.validateConfirmPassword(
                                value, bloc.passController.text),
                        obscureText: bloc.obscureConfPass,
                      ),
                      Gap(60),
                      CustomButton(
                        title: AppStrings.register.tr(),
                        onPressed: () {
                          if (bloc.formKey.currentState!.validate()) {
                            AppFunctions.unFocusKeyboard(context);
                            bloc.add(
                              SignUpEvent(
                                email: bloc.emailController.text,
                                confirmPassword: bloc.confPassController.text,
                              ),
                            );
                          }
                        },
                        isLoading: state is LoadingSignUpState,
                      ),
                      Gap(20),
                      LoginAndRegisterRichText(isLogin: false)
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

class LoginAndRegisterRichText extends StatelessWidget {
  const LoginAndRegisterRichText({
    super.key,
    required this.isLogin,
  });
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: isLogin
            ? "${AppStrings.haveNotAccount.tr()} "
            : "${AppStrings.haveAccount.tr()} ",
        style: mediumStyle(
          fontSize: 14,
          color: BlocProvider.of<ThemeCubit>(context).state
              ? Colors.white
              : Colors.black,
        ),
        children: [
          TextSpan(
            text: isLogin
                ? AppStrings.registerNow.tr()
                : AppStrings.loginNow.tr(),
            style: mediumStyle(
              fontSize: 14,
              color: AppColors.primary,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (isLogin) {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.registerScreen,
                  );
                } else {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.loginScreen,
                  );
                }
              },
          ),
        ],
      ),
    );
  }
}

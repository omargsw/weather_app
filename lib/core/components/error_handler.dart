import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/core/styles/app_text_style.dart';
import 'package:weather_app/core/utils/helpers/app_extensions.dart';

import '../styles/app_colors.dart';
import '../utils/helpers/app_functions.dart';
import '../utils/helpers/app_strings.dart';

class ErrorHandler extends StatelessWidget {
  const ErrorHandler({
    super.key,
    required this.message,
    this.errorCode,
    this.onPressed,
    this.buttonLabel,
    this.buttonSize,
  });
  final String message;
  final String? errorCode;
  final Size? buttonSize;
  final String? buttonLabel;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SvgPicture.asset(
                height: 100,
                width: 100,
                AppFunctions.mapFailureToImage(message),
              ),
              Gap(30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: regularStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              if (errorCode != null) ...[
                Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    // AppStrings.errorCode.tr().replaceAll(AppExpressions.textPattern, errorCode!),
                    errorCode!.toSentenceCase(),
                    textAlign: TextAlign.center,
                    style: lightStyle(fontSize: 16, color: Colors.black, height: 1),
                  ),
                ),
              ],
              Gap(20),
              if (onPressed != null)
                ElevatedButton(
                  onPressed: onPressed,
                  style: ButtonStyle(minimumSize: WidgetStateProperty.all(buttonSize ?? Size(250, 45))),
                  child: Text(
                    buttonLabel ?? AppStrings.tryAgain.tr(),
                    textAlign: TextAlign.center,
                    style: regularStyle(fontSize: 16, color: AppColors.white),
                  ),
                )
              else
                SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

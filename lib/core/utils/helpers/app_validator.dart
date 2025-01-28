import 'package:easy_localization/easy_localization.dart';
import 'package:weather_app/core/utils/helpers/app_strings.dart';

class AppValidator {
  AppValidator._();

  /// Validates that a regular field is not empty.
  static String? validateRegularField(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.errorEmptyField.tr();
    }
    return null;
  }

  /// Validates that the provided value is a valid email address.
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.errorEmptyField.tr();
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return AppStrings.invalidEmail.tr();
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.errorEmptyField.tr();
    }

    // Regular expression to allow only English and Arabic letters and spaces
    final regex = RegExp(r'^[a-zA-Z\u0621-\u064A\s]+$');

    if (!regex.hasMatch(value.trim())) {
      return AppStrings.enterVaildName.tr();
    }

    return null;
  }

  /// Validates that the provided password meets strength requirements.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.errorEmptyField.tr();
    }

    // Password must be at least 8 characters long
    if (value.length < 8) {
      return AppStrings.passwordErrorlong.tr();
    }

    // Password must include at least one uppercase letter, one lowercase letter, and one number
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)');
    if (!passwordRegex.hasMatch(value)) {
      return AppStrings.passwordErrorMessage.tr();
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return AppStrings.errorEmptyField.tr();
    }

    if (value != password) {
      return AppStrings.passwordNotMatch.tr();
    }

    return null;
  }
}

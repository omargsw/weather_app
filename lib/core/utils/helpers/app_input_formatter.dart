import 'package:flutter/services.dart';

class AppInputFormatter {
  AppInputFormatter._();

  /// Formatter to allow only numeric input.
  static TextInputFormatter onlyDigits() {
    return FilteringTextInputFormatter.digitsOnly;
  }

  static TextInputFormatter nameFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      final text = newValue.text;

      // Regular expression to allow English and Arabic letters, spaces, and apostrophes
      final regex = RegExp(r'^[a-zA-Z\u0621-\u064A\u0660-\u0669\s]*$');

      // Remove invalid characters
      final filteredText =
          text.split('').where((char) => regex.hasMatch(char)).join();

      return TextEditingValue(
        text: filteredText,
        selection: newValue.selection.copyWith(
          baseOffset: filteredText.length,
          extentOffset: filteredText.length,
        ),
      );
    });
  }

  /// Formatter to limit character count in the input field.
  static TextInputFormatter limitCharacter(int limit) {
    return LengthLimitingTextInputFormatter(limit);
  }

  /// Formatter to allow alphanumeric input only.
  static TextInputFormatter alphanumericFormatter() {
    return FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'));
  }

  /// Formatter to enforce a specific date format (dd/MM/yyyy).
  static TextInputFormatter dateFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String formatted = '';
      final digits = newValue.text
          .replaceAll(RegExp(r'\D'), ''); // Remove non-digit characters

      if (digits.isNotEmpty) formatted += digits.substring(0, 1);
      if (digits.length >= 2) formatted += '/${digits.substring(1, 2)}';
      if (digits.length >= 4) formatted += '/${digits.substring(3, 5)}';

      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    });
  }

  /// Formatter for email input that disallows spaces.
  static TextInputFormatter emailFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String formatted = newValue.text.replaceAll(' ', ''); // Remove spaces
      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    });
  }

  /// Formatter to remove leading zeros for numeric input.
  static TextInputFormatter removeLeadingZeros() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String newText = newValue.text.replaceAll(RegExp(r'^0+'), '');
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    });
  }
}

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AppInputFormatter {
  AppInputFormatter._();

  /// Formatter to allow only numeric input.
  static TextInputFormatter onlyDigits() {
    return FilteringTextInputFormatter.digitsOnly;
  }

  /// Formatter to format a phone number as it is typed.
  static TextInputFormatter phoneFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      // Only allow up to 10 digits
      if (newValue.text.length > 10) {
        return oldValue; // Reject if it exceeds 10 digits
      }

      // Simple phone formatting logic
      String formatted = '';
      if (newValue.text.isNotEmpty) formatted += '(${newValue.text.substring(0, 1)}';
      if (newValue.text.length >= 3) formatted += '${newValue.text.substring(1, 3)}) ';
      if (newValue.text.length >= 6) formatted += '${newValue.text.substring(3, 6)}-';
      if (newValue.text.length >= 10) formatted += newValue.text.substring(6, 10);

      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    });
  }

  /// Formatter for currency input.
  static TextInputFormatter currencyFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      // Remove any non-digit characters
      String newText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
      if (newText.isEmpty) {
        return TextEditingValue.empty;
      }

      // Format as currency
      final int amount = int.parse(newText);
      final String formatted = '\$${NumberFormat('#,##0').format(amount)}';

      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
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
      final digits = newValue.text.replaceAll(RegExp(r'\D'), ''); // Remove non-digit characters

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

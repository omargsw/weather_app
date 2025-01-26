class AppValidator {
  AppValidator._();

  /// Validates that a regular field is not empty.
  static String? validateRegularField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Empty field error';
    }
    return null;
  }

  /// Validates that the provided value is a valid email address.
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Empty field error';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email address';
    }

    return null;
  }

  /// Validates that the provided value is a valid phone number.
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Empty field error';
    }

    final phoneRegex =
        RegExp(r'^\+?[0-9]{10,15}$'); // Adjust based on your requirements
    if (!phoneRegex.hasMatch(value)) {
      return 'Invalid phone number';
    }

    return null;
  }

  /// Validates that the provided password meets strength requirements.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Empty field error';
    }

    // Password must be at least 8 characters long
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    // Password must include at least one uppercase letter, one lowercase letter, and one number
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)');
    if (!passwordRegex.hasMatch(value)) {
      return 'Password must include at least one uppercase letter, one lowercase letter, and one number';
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Empty field error';
    }

    if (value != password) {
      return "Passwords don't match";
    }

    return null;
  }
}

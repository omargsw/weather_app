extension StringExtensions on String {
  /// Extension to convert the first character of a string to uppercase.
  String toSentenceCase() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }

  /// Extension to convert the first character of each word in a string to uppercase.
  String capitalizeEachWord() {
    if (isEmpty) {
      return this;
    }
    return split(' ').map((word) => word.toSentenceCase()).join(' ');
  }

  /// Extension to check if a string is a valid email address.
  bool isValidEmail() {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(this);
  }

  /// Extension to check if a string is a valid URL.
  bool isValidUrl() {
    try {
      Uri.parse(this);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Extension to reverse the string.
  String reverse() {
    return split('').reversed.join('');
  }

  /// Extension to remove all whitespace from the string.
  String removeWhitespace() {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Extension to check if the string is a valid integer.
  bool isValidInteger() {
    return int.tryParse(this) != null;
  }
}

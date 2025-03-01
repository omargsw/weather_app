class ApiConstants {
  const ApiConstants._();

  /// BASE URL
  static String baseUrl = 'https://api.openweathermap.org';

  /// END POINTS
  static String weatherUrl = '/data/2.5/weather';

  ///  PARAMS

  /// HEADERS
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String applicationForm = 'application/x-www-form-urlencoded';
  static const String multipartFormData = 'multipart/form-data';
  static const String authorization = 'Authorization';
  static const String acceptLanguage = 'Accept-Language';
  static const String en = 'en';
  static const String ar = 'ar';
}

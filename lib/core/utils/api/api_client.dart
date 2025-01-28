import 'package:dio/dio.dart';
import 'package:weather_app/core/utils/helpers/app_logger.dart';

import 'api_constants.dart';

class ApiClient {
  static Dio? dio;

  /// Initializes [Dio] with base options and interceptors.
  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
        validateStatus: (statusCode) {
          final validStatusCodes = [
            200,
            201,
            204,
            202,
            400,
            401,
            404,
            405,
            500
          ];
          return validStatusCodes.contains(statusCode);
        },
      ),
    );
  }

  /// Sends a POST request to the given URL with data.
  static Future<Response?> postData({
    required String url,
    required Map<String, dynamic> data,
    String contentType = ApiConstants.applicationJson,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      return await dio!.post(
        url,
        options: Options(
          contentType: contentType,
          receiveDataWhenStatusError: true,
          headers: headers,
        ),
        queryParameters: queryParameters,
        data: data,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
      );
    } catch (error) {
      _handleError(error);
      return null;
    }
  }

  /// Sends a POST request with images.
  static Future<Response?> postDataWithImages({
    required String url,
    required FormData formData,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      return await dio!.post(
        url,
        options: Options(
            contentType: ApiConstants.multipartFormData, headers: headers),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        data: formData,
      );
    } catch (error) {
      _handleError(error);
      return null;
    }
  }

  /// Sends a GET request to the given URL.
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String contentType = ApiConstants.applicationJson,
  }) async {
    try {
      return await dio!.get(
        url,
        options: Options(
          receiveDataWhenStatusError: true,
          headers: headers,
          contentType: contentType,
        ),
        queryParameters: queryParameters,
      );
    } catch (error) {
      _handleError(error);
      throw Exception("API request failed: $error");
    }
  }

  /// Sends a DELETE request to the given URL.
  static Future<Response> delete({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
  }) async {
    return await dio!.delete(
      url,
      options: Options(headers: headers),
      queryParameters: queryParameters,
      data: data,
    );
  }

  /// Sends a PUT request to the given URL.
  static Future<Response> put({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    required Map<String, dynamic> data,
  }) async {
    return await dio!.put(
      url,
      data: data,
      options: Options(headers: headers),
      queryParameters: queryParameters,
    );
  }

  /// Sends a PATCH request with images to the given URL.
  static Future<Response?> patchDataWithImage({
    required String url,
    required FormData formData,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return await dio?.patch(
      url,
      options: Options(contentType: 'multipart/form-data', headers: headers),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      data: formData,
    );
  }

  /// Sends a PATCH request to the given URL.
  static Future<Response> patch({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    String contentType = ApiConstants.applicationJson,
  }) async {
    return await dio!.patch(
      url,
      options: Options(headers: headers, contentType: contentType),
      queryParameters: queryParameters,
      data: data,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    );
  }

  /// Handles error logging and processing.
  static void _handleError(dynamic error) {
    if (error is DioException) {
      AppLogger.error(
          "Error response {API Client Error} : ${error.response?.statusCode} - ${error.response?.data}");
      AppLogger.error(
          "Error request {API Client Request}: ${error.requestOptions.uri}");
    } else {
      AppLogger.error("Unknown error: ${error.toString()}");
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/core/services/index.dart';
import '../exceptions/general_exception.dart';

class ApiService {
  static const String _baseUrl = NetworkStrings.backendUrl;
  static const int _timeout = 30;
  final Dio _dio;

  ApiService() : _dio = Dio(BaseOptions(baseUrl: _baseUrl, connectTimeout: Duration(seconds: _timeout))) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (kDebugMode) {
            LoggerService.log('REQUEST [${options.method}] => PATH: ${options.path}', name: 'ApiService');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            LoggerService.log('RESPONSE [${response.statusCode}] => PATH: ${response.requestOptions.path}',
                name: 'ApiService');
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (kDebugMode) {
            LoggerService.logError(
              e,
              message: '"ERROR [${e.response?.statusCode}] => PATH: ${e.requestOptions.path}"',
              name: 'ApiService',
            );
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
    } catch (e) {
      throw GeneralException(message: 'Unexpected error');
    }
  }

  Future<dynamic> post(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
    } catch (e) {
      throw GeneralException(message: 'Unexpected error');
    }
  }

  Never _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      throw GeneralException(
        message: 'Connection timeout',
      );
    }

    if (e.response != null) {
      final String message = e.response?.data?['message'] ?? 'Unknown error';
      throw GeneralException(
        message: message,
        statusCode: e.response?.statusCode,
        data: e.response?.data,
      );
    } else {
      throw const GeneralException(
        message: 'Could not connect to the server',
      );
    }
  }
}

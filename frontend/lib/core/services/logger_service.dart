import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

/// Service to handle logs in the application.
/// Only shows logs when the application is in debug mode.
class LoggerService {
  /// Logs a message to the console only if the application is in debug mode.
  /// 
  /// [message] - The message to be logged.
  /// [error] - Optional error to be logged.
  /// [stackTrace] - Optional StackTrace to help with debugging.
  /// [name] - Optional name to categorize the log.
  static void log(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String name = 'APP',
  }) {
    if (kDebugMode) {
      developer.log(
        message,
        error: error,
        stackTrace: stackTrace,
        name: name,
        time: DateTime.now(),
      );
    }
  }

  /// Logs an error to the console only if the application is in debug mode.
  /// 
  /// [error] - The error to be logged.
  /// [stackTrace] - Optional StackTrace, if not provided the current one is used.
  /// [message] - Optional descriptive message about the error.
  /// [name] - Optional name to categorize the log.
  static void logError(
    Object error, {
    StackTrace? stackTrace,
    String? message,
    String name = 'ERROR',
  }) {
    if (kDebugMode) {
      final errorMessage = message != null 
          ? '$message: $error' 
          : error.toString();
      
      developer.log(
        errorMessage,
        error: error,
        stackTrace: stackTrace ?? StackTrace.current,
        name: name,
        time: DateTime.now(),
      );
    }
  }
} 
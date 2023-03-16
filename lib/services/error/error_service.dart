import 'dart:io';

import 'package:app_cargo/domain/driver_sign_up/driver_sign_up.dart';
import 'package:app_cargo/domain/login_response/login_response.dart';
import 'package:app_cargo/http/app_cargo_client.dart';
import 'package:dio/dio.dart';
import 'package:sentry/sentry.dart';

class ErrorService {
  final SentryClient _sentry = SentryClient(
      dsn: "https://15fbf9c5cfdc4f958d95e5e848314b7a@sentry.io/1764031");

  static final SentryClient loginSentry = SentryClient(
      dsn: "https://15fbf9c5cfdc4f958d95e5e848314b7a@sentry.io/1764031");

  Future<void> reportError(
      dynamic error, dynamic stackTrace, bool isInDebugMode) async {
    // Print the exception to the console.
    print('Caught error: $error');
    if (isInDebugMode) {
      // Print the full stacktrace in debug mode.
      print(stackTrace);
      return;
    } else {
      // Send the Exception and Stacktrace to Sentry in Production mode.
      _sentry.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    }
  }

  static Future<void> reportLoginError(
      dynamic error, dynamic stackTrace) async {
    // Print the exception to the console.
    print('Caught error: $error');
    // Send the Exception and Stacktrace to Sentry in Production mode.
    loginSentry.captureException(
      exception: 'LOGIN ERROR: ${error}',
      stackTrace: 'STRACKTRACE $stackTrace',
    );
  }
}

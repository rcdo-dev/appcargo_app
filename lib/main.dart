import 'dart:async';
import 'dart:io';

import 'package:app_cargo/app.dart';
import 'package:app_cargo/services/error/error_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'di/container.dart';

final ErrorService errorService = DIContainer().get<ErrorService>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Here we can do everything we need before the splash screen exits
  // https://medium.com/@diegoveloper/flutter-splash-screen-9f4e05542548
  // https://flutter.dev/docs/development/ui/assets-and-images#updating-the-launch-screen
  // https://github.com/zubairehman/flutter-boilerplate-project/blob/master/lib/main.dart
  //
  HttpOverrides.global = new MyHttpOverrides();
  initContainer();

  // This captures errors reported by the Flutter framework.
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report to
      // Sentry.

      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  // Monitor the driver in background.
  // Request first permissions in app intialize
  // locationService.initBackgroundMonitoring();

  runZoned<Future<void>>(() async {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).whenComplete(() => runApp(App()));
  }, onError: (error, stackTrace) {
    // Whenever an error occurs, call the `_reportError` function. This sends
    // Dart errors to the dev console or Sentry depending on the environment.
    errorService.reportError(error, stackTrace, isInDebugMode);
  });
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

bool get isInDebugMode {
  // Assume you're in production mode.
  bool inDebugMode = false;

  // Assert expressions are only evaluated during development. They are ignored
  // in production. Therefore, this code only sets `inDebugMode` to true
  // in a development environment.
  assert(inDebugMode = true);

  return inDebugMode;
}

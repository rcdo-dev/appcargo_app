import 'dart:async';

import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:dio/dio.dart';

class AccessTokenInterceptor extends Interceptor {
  @override
  FutureOr onRequest(RequestOptions options) {
    return DIContainer().get<ConfigurationService>().accessToken.then((accessToken) {
      if (null != accessToken) {
        options.headers.putIfAbsent('X-Access-Token', () => accessToken);
      }
      return options;
    }).then((_) {
      super.onRequest(options);
    });
  }
}
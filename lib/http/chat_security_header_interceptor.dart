import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/header_security/header_security.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class ChatSecurityHeaderInterceptor extends Interceptor {

  @override
  FutureOr onRequest(RequestOptions options) {
    return DIContainer()
        .get<ConfigurationService>()
        .securityHeader
        .then((securityHeader) {
      if (null != securityHeader) {
        options.headers.putIfAbsent(
            'newgo-security', () => securityHeader);
      }
      return options;
    }).then((_) => {super.onRequest(options)});
  }
}

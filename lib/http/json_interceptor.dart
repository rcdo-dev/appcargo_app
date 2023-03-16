import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

class JsonInterceptor extends Interceptor {
  @override
  FutureOr<dynamic> onResponse(Response response) {
    if ('application/json' == response.headers.contentType.mimeType) {
    }
  }
}
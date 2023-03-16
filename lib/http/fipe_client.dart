import 'dart:convert';

import 'package:app_cargo/domain/util/json_mapper.dart';
import 'package:app_cargo/domain/util/list_mapper.dart';
import 'package:dio/dio.dart';

import 'api_error.dart';

// From https://github.com/zubairehman/flutter-boilerplate-project/blob/master/lib/data/network/dio_client.dart

class FIPEClient {
  final Dio _dio;

  FIPEClient(this._dio);

  Future<T> getList<T>(
    String uri,
    ListMapper<T> mapper, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    return _dio
        .get<List<dynamic>>(
      uri,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    )
        .then((response) {
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return mapper(response.data);
      }

      throw Exception(
          ["Fipe's api returned a 404 error, see your request again."]);
    });
  }

  Future<T> getObject<T>(
    String uri,
    JsonMapper<T> mapper, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    return _dio
        .get<Map<String, dynamic>>(
      uri,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    )
        .then((response) {
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return mapper(response.data);
      }

      throw Exception(
          ["Fipe's api returned a 404 error, see your request again."]);
    });
  }
}

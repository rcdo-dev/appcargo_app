import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:app_cargo/constants/endpoints.dart';
import 'package:app_cargo/domain/util/json_mapper.dart';
import 'package:app_cargo/domain/util/list_mapper.dart';
import 'package:app_cargo/http/api_error.dart';
import 'package:app_cargo/http/handle_client_error.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class FreightChatClient {
  final Dio _dio;

  FreightChatClient(this._dio);

  Future<T> get<T>(
    String uri,
    ListMapper<T> mapper, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) {
    return _dio
        .get<List<dynamic>>(
      Endpoints.freightBaseUrl + uri,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    )
        .then((response) {
      log("Log personal driver data: ${response.data}");

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return mapper(response.data);
      }

      throw ApiError.listFromJson((response.data));
    });
  }

  Future<T> getFreightsFromAppCargo<T>(
    String uri,
    ListMapper<T> mapper, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) {
    return _dio
        .get<List<dynamic>>(
      Endpoints.mobileBaseUrl + uri,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    )
        .then((response) {
      // log("Log personal driver data: ${response.data}");

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return mapper(response.data);
      }

      throw ApiError.listFromJson((response.data));
    });
  }

  Future<T> post<T>(
    String uri,
    JsonMapper<T> mapper, {
    data,
    Map<String, dynamic> queryParameters,
    Map<String, File> files,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    if (null != files && files.isNotEmpty) {
      if (data is! FormData) {
        throw "Error: files can't be sent if the request data is not a FormData instance";
      }

      files.forEach((key, file) {
        if (null != file && null != file.path && file.path.isNotEmpty) {
          var fileInfo = UploadFileInfo(file, basename(file.path));
          data.add(key, fileInfo);
        }
      });
    }

    return _dio
        .post<Map<String, dynamic>>(
      Endpoints.freightBaseUrl + uri,
      data: data is FormData ? data : jsonEncode(data),
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    )
        .then((response) {
      if (mapper == null) return null;
      return mapper(response.data);
    }).catchError((error) {
      return _handleError(error);
    });
  }

  Future<void> delete(
      String uri, {
        data,
        Map<String, dynamic> queryParameters,
        Options options,
        CancelToken cancelToken,
      }) async {
    return _dio
        .delete<Map<String, dynamic>>(
      Endpoints.freightBaseUrl + uri,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    )
        .then((response) {
      if (response.statusCode >= 200 || response.statusCode <= 299) {
        throw ApiError.listFromJson(
            (response.data['errors'] ?? []) as List<Map<String, dynamic>>);
      }
    }).catchError((error) => _handleError(error));
  }

  List<ApiError> _handleError(error) {
    if (null == error.response) {
      return [
        ApiError("UNHANDLED_EXCEPTION",
            details: HandleClientError.handleError(error)),
      ];
    }

    return ApiError.listFromJson(
        (error.response.data['errors'] ?? []) as List<dynamic>);
  }
}

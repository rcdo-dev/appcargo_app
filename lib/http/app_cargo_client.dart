import 'dart:convert';
import 'dart:io';

import 'package:app_cargo/constants/endpoints.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/util/json_mapper.dart';
import 'package:app_cargo/domain/util/list_mapper.dart';
import 'package:app_cargo/services/error/error_service.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'api_error.dart';
import 'handle_client_error.dart';
import 'dart:developer';

// From https://github.com/zubairehman/flutter-boilerplate-project/blob/master/lib/data/network/dio_client.dart

class AppCargoClient {
  final Dio _dio;

  AppCargoClient(this._dio);

  Future<T> get<T>(
    String uri,
    JsonMapper<T> mapper, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) {
    return _dio
        .get<Map<String, dynamic>>(
      Endpoints.mobileBaseUrl + uri,
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

      throw ApiError.listFromJson(
          (response.data['errors'] ?? []) as List<Map<String, dynamic>>);
    });
  }

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
      Endpoints.mobileBaseUrl + uri,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    )
        .then((response) {
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return mapper(response.data);
      }

      throw Exception(["Retrieve my simulations error."]);
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
      Endpoints.mobileBaseUrl + uri,
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
      if (error != null) {
        ErrorService.reportLoginError(error, error);
      }
      return _handleError(error);
    });
  }

  Future<T> postWithoutHandleError<T>(
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
      Endpoints.mobileBaseUrl + uri,
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
      throw error;
    });
  }

  Future<T> put<T>(
    String uri, {
    JsonMapper<T> mapper,
    Map<String, dynamic> data,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
    ResponseType responseType = ResponseType.plain,
  }) async {
    return _dio
        .put<Map<String, dynamic>>(
      Endpoints.mobileBaseUrl + uri,
      data: jsonEncode(data),
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    )
        .then((response) {
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        if (mapper != null)
          return mapper(response.data);
        else
          return null;
      }

      throw ApiError.listFromJson(
          (response.data['errors'] ?? []) as List<Map<String, dynamic>>);
    }).catchError((error) => _handleError(error));
  }

  Future<T> putStringResponse<T>(
    String uri, {
    StringMapper<T> mapper,
    Map<String, dynamic> data,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
    ResponseType responseType = ResponseType.plain,
  }) async {
    return _dio
        .put<String>(
      Endpoints.mobileBaseUrl + uri,
      data: jsonEncode(data),
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    )
        .then((response) {
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        if (mapper != null)
          return mapper(response.data);
        else
          return null;
      }

      throw Exception(response);
    }).catchError((error) {
      if (error != "") {
        print("Error in send form data: ${error}");
      }
    });
  }

  Future<T> postMultipart<T>(
    String uri, {
    JsonMapper<T> mapper,
    data,
    Map<String, dynamic> queryParameters,
    Map<String, File> files,
    CancelToken cancelToken,
    Options options,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
    ResponseType responseType = ResponseType.plain,
  }) async {
    Map<String, dynamic> flatJson = Map();
    if (data != null) {
      flatJson = _putFlattenMap(data, "");
    }

    FormData formData = FormData();
    formData.addAll(flatJson);

    if (null != files && files.isNotEmpty) {
      if (formData is! FormData) {
        throw "Error: files can't be sent if the request data is not a FormData instance";
      }

      files.forEach((key, file) {
        if (null != file && null != file.path && file.path.isNotEmpty) {
          var fileInfo = UploadFileInfo(file, basename(file.path));
          formData.add(key, fileInfo);
        }
      });
    }

    return _dio
        .post<Map<String, dynamic>>(
      Endpoints.mobileBaseUrl + uri,
      data: formData is FormData ? formData : jsonEncode(formData),
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    )
        .then((response) {
      return mapper(response.data);
    }).catchError((error) => _handleError(error));
  }

  Future<T> putMultipart<T>(
    String uri, {
    JsonMapper<T> mapper,
    data,
    Map<String, dynamic> queryParameters,
    Map<String, File> files,
    CancelToken cancelToken,
    Options options,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
    ResponseType responseType = ResponseType.plain,
  }) async {
    Map<String, dynamic> flatJson = _putFlattenMap(data, "");

    FormData formData = FormData();
    formData.addAll(flatJson);

    if (null != files && files.isNotEmpty) {
      if (formData is! FormData) {
        throw "Error: files can't be sent if the request data is not a FormData instance";
      }

      files.forEach((key, file) {
        if (null != file && null != file.path && file.path.isNotEmpty) {
          var fileInfo = UploadFileInfo(file, basename(file.path));
          formData.add(key, fileInfo);
        }
      });
    }

    return _dio
        .put<Map<String, dynamic>>(
      Endpoints.mobileBaseUrl + uri,
      data: formData is FormData ? formData : jsonEncode(formData),
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    )
        .then((response) {
      return mapper(response.data);
    }).catchError((error) => _handleError(error));
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
      Endpoints.mobileBaseUrl + uri,
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

  Map<String, dynamic> _putFlattenMap(
      Map<String, dynamic> original, String prefix) {
    Map<String, dynamic> result = new Map();

    original.forEach((key, val) {
      if (val is Map) {
        result.addAll(_putFlattenMap(val, prefix + key + "."));
      } else if (val is List) {
        result.addAll(_handleList(val, prefix + key));
      } else if (null != val) {
        result[prefix + key] = val;
      }
    });

    return result;
  }

  Map<String, dynamic> _handleList(List list, String prefix) {
    Map<String, dynamic> result = new Map();

    int i = 0;
    list.forEach((val) {
      String prefixNextLevel = prefix + "[$i].";

      if (val is Map) {
        result.addAll(_putFlattenMap(val, prefixNextLevel));
      } else if (val is List) {
        result.addAll(_handleList(val, prefixNextLevel));
      } else if (null != val) {
        result[prefix + "[$i]"] = val;
      }

      i++;
    });

    return result;
  }
}

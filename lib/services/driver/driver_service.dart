import 'dart:io';

import 'package:app_cargo/domain/driver_sign_up/driver_sign_up.dart';
import 'package:app_cargo/domain/login_response/login_response.dart';
import 'package:app_cargo/domain/pre_driver_data/pre_driver_data.dart';
import 'package:app_cargo/http/app_cargo_client.dart';
import 'package:dio/dio.dart';

LoginResponse _mapToLoginResponse(Map<String, dynamic> json) {
  return LoginResponse.fromJson(json);
}

class DriverService {
  AppCargoClient _dioClient;

  DriverService(this._dioClient);

  Future<dynamic> signUp(DriverSignUp driver) {
    Map<String, dynamic> originalJson = DriverSignUp.toJson(driver);
    Map<String, dynamic> flatJson = flattenMap(originalJson, "");

    FormData formData = FormData();
    formData.addAll(flatJson);

    return this._dioClient.post<dynamic>(
      "/v3/signUp",
      _mapToLoginResponse,
      data: formData,
      // files: driver.files,
      options: Options(
        contentType: ContentType.parse("multipart/form-data;charset=UTF-8"),
      ),
    );
  }

  Future<dynamic> savePreDriverData(PreDriverData domain) {
    Map<String, dynamic> originalJson = PreDriverData.toJson(domain);
    Map<String, dynamic> flatJson = flattenMap(originalJson, "");

    FormData formData = FormData();
    formData.addAll(flatJson);

    return this._dioClient.post<dynamic>(
      "/v1/preDriverData",
      null,
      data: formData,
      // files: driver.files,
      options: Options(
        contentType: ContentType.parse("multipart/form-data;charset=UTF-8"),
      ),
    );
  }

  Map<String, dynamic> flattenMap(
      Map<String, dynamic> original, String prefix) {

    Map<String, dynamic> result = new Map();

    original.forEach((key, val) {
      if (val is Map) {
        result.addAll(flattenMap(val, prefix + key + "."));
      } else if (val is List) {
        result.addAll(handleList(val, prefix + key));
      } else if (null != val) {
        result[prefix + key] = val;
      }
    });

    return result;
  }


  Map<String, dynamic> handleList(List list, String prefix) {
    Map<String, dynamic> result = new Map();

    int i = 0;
    list.forEach((val) {
      String prefixNextLevel = prefix + "[$i].";

      if (val is Map) {
        result.addAll(flattenMap(val, prefixNextLevel));
      } else if (val is List) {
        result.addAll(handleList(val, prefixNextLevel));
      } else if (null != val) {
        result[prefix + "[$i]"] = val;
      }

      i++;
    });

    return result;
  }
}

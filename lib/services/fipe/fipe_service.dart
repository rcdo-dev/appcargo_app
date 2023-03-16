import 'dart:core';

import 'package:app_cargo/constants/endpoints.dart';
import 'package:app_cargo/domain/fipe_brand/fipe_brand.dart';
import 'package:app_cargo/domain/fipe_model_summary/fipe_model_summary.dart';
import 'package:app_cargo/domain/fipe_model_year_summary/fipe_model_year_summary.dart';
import 'package:app_cargo/domain/make_type.dart';
import 'package:app_cargo/http/fipe_client.dart';
import 'package:dio/dio.dart';

List<FipeBrand> _mapToListFipeBrand(List<dynamic> json) {
  List<FipeBrand> _brands = new List<FipeBrand>();
  for (Map<String, dynamic> brand in json) {
    _brands.add(FipeBrand.fromJson(brand));
  }
  return _brands;
}

List<FipeModelSummary> _mapToListFipeModelSummary(List<dynamic> json) {
  return json.map((e) => FipeModelSummary.fromJson(e)).toList();
}

List<FipeModelYearSummary> _mapToListFipeModelYearSummary(List<dynamic> json) {
  return json.map((e) => FipeModelYearSummary.fromJson(e)).toList();
}

class FIPEService {
  FIPEClient _dioClient;

  FIPEService(this._dioClient);

  Future<List<FipeBrand>> getBrands([MakeType makeType = MakeType.truck]) {
    return this
        ._dioClient
        .getList(
            Endpoints.mobileBaseUrl + "/v1/fipe/brands", _mapToListFipeBrand,
            queryParameters: {
              if (MakeType.truck == makeType) 'makeType': 'TRUCK',
              if (MakeType.car_or_utilitary == makeType)
                'makeType': 'CAR_OR_UTILITARY',
            },
            options: Options(
              responseType: ResponseType.plain,
            ))
        .catchError((e) {
      throw e;
    });
  }

  Future<List<FipeModelSummary>> getModels(
      FipeBrand brand, FipeModelYearSummary year) {
    return this
        ._dioClient
        .getList(
          Endpoints.mobileBaseUrl +
              "/v1/fipe/brands/${brand.id}/modelYears/${year.name}/models",
          _mapToListFipeModelSummary,
        )
        .catchError((e) {
      throw e;
    });
  }

  Future<List<FipeModelYearSummary>> getModelYears(
    FipeBrand brand,
  ) {
    return this
        ._dioClient
        .getList(
          Endpoints.mobileBaseUrl + "/v1/fipe/brands/${brand.id}/modelYears",
          _mapToListFipeModelYearSummary,
        )
        .catchError((e) {
      throw e;
    });
  }
}

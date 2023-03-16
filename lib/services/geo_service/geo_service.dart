import 'dart:math';

import 'package:app_cargo/domain/geo/distance_dto.dart';
import 'package:app_cargo/domain/geo/origin_and_destiny.dart';
import 'package:app_cargo/http/app_cargo_client.dart';

DistanceDTO _mapToDistanceDTO(Map<String, dynamic> json) {
  return DistanceDTO.fromJson(json);
}

class GeoService {
  AppCargoClient _dioClient;

  GeoService(this._dioClient);

  Future<dynamic> getDistanceInMetersBetweenTwoPoints(
      OriginAndDestiny originAndDestiny) {
    return this
        ._dioClient
        .post("/distanceInMeters", _mapToDistanceDTO,
            data: OriginAndDestiny.toJson(originAndDestiny))
        .catchError((e) {
      throw (e);
    });
  }
}

import 'package:app_cargo/domain/driver_personal_data/driver_personal_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver_personal_data_photo.g.dart';

@JsonSerializable()
class DriverPersonalDataPhoto {
  String personalPhotoUrl;

  DriverPersonalDataPhoto({this.personalPhotoUrl});

  static Map<String, dynamic> toJson(
      DriverPersonalDataPhoto driverPersonalDataPhoto) {
    return _$DriverPersonalDataPhotoToJson(driverPersonalDataPhoto);
  }

  static dynamic fromJson(Map<String, dynamic> json) {
    try {
      return _$DriverPersonalDataPhotoFromJson(json);
    } catch (e) {
      return json;
    }
  }

  DriverPersonalData updatePersonalDataWithReceivedPhotoUrl(
      DriverPersonalData driverPersonalData) {
    DriverPersonalData driverPersonalDataUpdated = new DriverPersonalData();

    if (driverPersonalData != null) {
      driverPersonalData.personalPhotoUrl = this.personalPhotoUrl;
      driverPersonalDataUpdated = driverPersonalData;
    }

    return driverPersonalDataUpdated;
  }
}

import 'package:json_annotation/json_annotation.dart';

part 'driver_social_data.g.dart';

@JsonSerializable()
class DriverSocialData {
  String facebook;
  String instagram;

  DriverSocialData({
    this.facebook,
    this.instagram,
  });

  static dynamic toJson(DriverSocialData driverSocialData) {
    if (driverSocialData != null)
      return _$DriverSocialDataToJson(driverSocialData);
    else
      return driverSocialData;
  }

  static DriverSocialData fromJson(Map<String, dynamic> json) {
    if (json != null)
      return _$DriverSocialDataFromJson(json);
    else
      return null;
  }
}

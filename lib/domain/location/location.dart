import 'package:json_annotation/json_annotation.dart';
import 'package:app_cargo/http/transformers.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {

  @JsonKey(toJson: genericStringCleaner)
  String instant;
  double latitude;
  double longitude;
  double accuracy;
  double batteryLevel;
  double odometer;
  bool isMoving;

  Location(String instant, double latitude, double longitude, double accuracy, double batteryLevel, double odometer, bool isMoving) {
    this.instant = instant;
    this.latitude = latitude;
    this.longitude = longitude;
    this.accuracy = accuracy;
    this.batteryLevel = batteryLevel;
    this.odometer = odometer;
    this.isMoving = isMoving;
  }

  static Map<String, dynamic> toJson(
          Location location) {
    return _$LocationToJson(location);
  }

  static Location fromJson(Map<String, dynamic> json) {
    return _$LocationFromJson(json);
  }
}

import 'package:app_cargo/http/transformers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver_emergency_data.g.dart';

@JsonSerializable()
class DriverEmergencyData {
  String name;
  String relation;
  @JsonKey(toJson: genericStringCleaner)
  String cellNumber;

  DriverEmergencyData({this.cellNumber, this.name, this.relation});

  static dynamic toJson(DriverEmergencyData driverEmergencyData) {
    if (driverEmergencyData != null)
      return _$DriverEmergencyDataToJson(driverEmergencyData);
    else
      return null;
  }

  static DriverEmergencyData fromJson(Map<String, dynamic> json) {
    if (json != null)
      return _$DriverEmergencyDataFromJson(json);
    else
      return null;
  }
}

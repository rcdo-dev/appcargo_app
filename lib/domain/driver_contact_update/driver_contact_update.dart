import 'package:app_cargo/domain/driver_contact_data/driver_contact_data.dart';
import 'package:app_cargo/domain/driver_emergency_data/driver_emergency_data.dart';
import 'package:app_cargo/domain/driver_social_data/driver_social_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver_contact_update.g.dart';

@JsonSerializable()
class DriverContactUpdate {
  @JsonKey(toJson: DriverContactData.toJson, fromJson: DriverContactData.fromJson)
  DriverContactData contact;
  @JsonKey(toJson: DriverSocialData.toJson, fromJson: DriverSocialData.fromJson)
  DriverSocialData social;
  @JsonKey(
      toJson: DriverEmergencyData.toJson,
      fromJson: DriverEmergencyData.fromJson)
  DriverEmergencyData emergency;

  DriverContactUpdate({this.contact, this.emergency, this.social});

  static Map<String, dynamic> toJson(DriverContactUpdate driverContactUpdate) {
    return _$DriverContactUpdateToJson(driverContactUpdate);
  }

  static DriverContactUpdate fromJson(Map<String, dynamic> json) {
    return _$DriverContactUpdateFromJson(json);
  }
}

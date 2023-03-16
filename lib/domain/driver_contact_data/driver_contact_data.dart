import 'package:app_cargo/domain/city/city.dart';
import 'package:app_cargo/domain/lat_lng/lat_lng.dart';
import 'package:app_cargo/domain/state/state.dart';
import 'package:app_cargo/http/transformers.dart';
import 'package:date_format/date_format.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver_contact_data.g.dart';

@JsonSerializable()
class DriverContactData {
  @JsonKey(toJson: genericStringCleaner)
  String cep;
  String street;
  @JsonKey(fromJson: DriverContactData.fromNumberMapToString)
  String number;
  String neighborhood;
  @JsonKey(toJson: AddressState.toJson, fromJson: AddressState.fromJson)
  AddressState state;
  @JsonKey(fromJson: City.fromJson, toJson: City.toJson)
  City city;
  String formatted;
  @JsonKey(toJson: genericStringCleaner)
  String cellNumber;

  DriverContactData({
    this.state,
    this.number,
    this.cellNumber,
    this.cep,
    this.neighborhood,
    this.street,
    this.formatted,
    this.city,
  });

  static dynamic toJson(DriverContactData driverContactData) {
    if (driverContactData != null)
      return _$DriverContactDataToJson(driverContactData);
    else
      return null;
  }

  static DriverContactData fromJson(Map<String, dynamic> json) {
    if (json != null)
      return _$DriverContactDataFromJson(json);
    else
      return null;
  }

  static String fromNumberMapToString(dynamic number) {
    return number.toString();
  }
}

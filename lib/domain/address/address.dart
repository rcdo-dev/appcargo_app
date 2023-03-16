import 'package:app_cargo/constants/converters.dart';
import 'package:app_cargo/domain/city/city.dart';
import 'package:app_cargo/domain/lat_lng/lat_lng.dart';
import 'package:app_cargo/domain/state/state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  String cep;
  String street;
  @JsonKey(toJson: int.parse, fromJson: Converters.from)
  String number;
  String neighborhood;
  @JsonKey(toJson: AddressState.toJson, fromJson: AddressState.fromJson)
  AddressState state;
  @JsonKey(toJson: City.toJson, fromJson: City.fromJson)
  City city;
  @JsonKey(toJson: LatLng.toJson, fromJson: LatLng.fromJson)
  LatLng position;
  String formatted;

  Address({
    this.number,
    this.position,
    this.neighborhood,
    this.cep,
    this.state,
    this.city,
    this.street,
    this.formatted,
  });

  static Map<String, dynamic> toJson(Address address) {
    return _$AddressToJson(address);
  }

  static Address fromJson(Map<String, dynamic> json) {
    return _$AddressFromJson(json);
  }
}

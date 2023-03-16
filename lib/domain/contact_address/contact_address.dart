import 'package:app_cargo/domain/city/city.dart';
import 'package:app_cargo/domain/lat_lng/lat_lng.dart';
import 'package:app_cargo/domain/state/state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_address.g.dart';

@JsonSerializable()
class ContactAddress {
  String cep;
  String street;
  String number;
  String neighborhood;
  @JsonKey(toJson: AddressState.toJson, fromJson: AddressState.fromJson)
  AddressState state;
  @JsonKey(toJson: City.toJson, fromJson: City.fromJson)
  City city;
  @JsonKey(toJson: LatLng.toJson, fromJson: LatLng.fromJson)
  LatLng position;
  String formatted;
  String cellNumber;

  ContactAddress({
    this.number,
    this.position,
    this.neighborhood,
    this.cep,
    this.state,
    this.city,
    this.street,
    this.formatted,
    this.cellNumber,
  });

  static Map<String, dynamic> toJson(ContactAddress address) {
    return _$ContactAddressToJson(address);
  }

  static ContactAddress fromJson(Map<String, dynamic> json) {
    return _$ContactAddressFromJson(json);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactAddress _$ContactAddressFromJson(Map<String, dynamic> json) {
  return ContactAddress(
    number: json['number'] as String,
    position: LatLng.fromJson(json['position'] as Map<String, dynamic>),
    neighborhood: json['neighborhood'] as String,
    cep: json['cep'] as String,
    state: AddressState.fromJson(json['state'] as Map<String, dynamic>),
    city: City.fromJson(json['city'] as Map<String, dynamic>),
    street: json['street'] as String,
    formatted: json['formatted'] as String,
    cellNumber: json['cellNumber'] as String,
  );
}

Map<String, dynamic> _$ContactAddressToJson(ContactAddress instance) =>
    <String, dynamic>{
      'cep': instance.cep,
      'street': instance.street,
      'number': instance.number,
      'neighborhood': instance.neighborhood,
      'state': AddressState.toJson(instance.state),
      'city': City.toJson(instance.city),
      'position': LatLng.toJson(instance.position),
      'formatted': instance.formatted,
      'cellNumber': instance.cellNumber,
    };

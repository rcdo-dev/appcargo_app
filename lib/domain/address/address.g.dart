// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    number: Converters.from(json['number']),
    position: LatLng.fromJson(json['position'] as Map<String, dynamic>),
    neighborhood: json['neighborhood'] as String,
    cep: json['cep'] as String,
    state: AddressState.fromJson(json['state'] as Map<String, dynamic>),
    city: City.fromJson(json['city'] as Map<String, dynamic>),
    street: json['street'] as String,
    formatted: json['formatted'] as String,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'cep': instance.cep,
      'street': instance.street,
      'number': int.parse(instance.number),
      'neighborhood': instance.neighborhood,
      'state': AddressState.toJson(instance.state),
      'city': City.toJson(instance.city),
      'position': LatLng.toJson(instance.position),
      'formatted': instance.formatted,
    };

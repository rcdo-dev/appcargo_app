// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_contact_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverContactData _$DriverContactDataFromJson(Map<String, dynamic> json) {
  return DriverContactData(
    state: AddressState.fromJson(json['state'] as Map<String, dynamic>),
    number: DriverContactData.fromNumberMapToString(json['number']),
    cellNumber: json['cellNumber'] as String,
    cep: json['cep'] as String,
    neighborhood: json['neighborhood'] as String,
    street: json['street'] as String,
    formatted: json['formatted'] as String,
    city: City.fromJson(json['city'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DriverContactDataToJson(DriverContactData instance) =>
    <String, dynamic>{
      'cep': genericStringCleaner(instance.cep),
      'street': instance.street,
      'number': instance.number,
      'neighborhood': instance.neighborhood,
      'state': AddressState.toJson(instance.state),
      'city': City.toJson(instance.city),
      'formatted': instance.formatted,
      'cellNumber': genericStringCleaner(instance.cellNumber),
    };

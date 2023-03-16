// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressState _$AddressStateFromJson(Map<String, dynamic> json) {
  return AddressState(
    name: json['name'] as String,
    hash: json['hash'] as String,
    acronym: json['acronym'] as String,
    cities: (json['cities'] as List)
        ?.map(
            (e) => e == null ? null : City.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AddressStateToJson(AddressState instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'name': instance.name,
      'acronym': instance.acronym,
      'cities': AddressState.citiesToJson(instance.cities),
    };

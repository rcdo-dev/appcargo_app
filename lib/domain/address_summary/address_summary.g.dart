// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressSummary _$AddressSummaryFromJson(Map<String, dynamic> json) {
  return AddressSummary(
    cityHash: json['cityHash'] as String,
    cityName: json['cityName'] as String,
    stateAcronym: json['stateAcronym'] as String,
    stateHash: json['stateHash'] as String,
    position: LatLng.fromJson(json['position'] as Map<String, dynamic>),
    formatted: json['formatted'] as String,
  );
}

Map<String, dynamic> _$AddressSummaryToJson(AddressSummary instance) =>
    <String, dynamic>{
      'cityHash': instance.cityHash,
      'stateHash': instance.stateHash,
      'cityName': instance.cityName,
      'stateAcronym': instance.stateAcronym,
      'position': LatLng.toJson(instance.position),
      'formatted': instance.formatted,
    };

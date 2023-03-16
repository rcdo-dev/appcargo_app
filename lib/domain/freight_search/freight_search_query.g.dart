// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freight_search_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreightSearchQuery _$FreightSearchQueryFromJson(Map<String, dynamic> json) {
  return FreightSearchQuery(
    position: LatLng.fromJson(json['position'] as Map<String, dynamic>),
    antt: json['antt'] as bool,
    destinationCityHash: json['destinationCityHash'] as String,
    destinationRadiusInKM: json['destinationRadiusInKM'] as int,
    originCityHash: json['originCityHash'] as String,
    originRadiusInKM: json['originRadiusInKM'] as int,
  );
}

Map<String, dynamic> _$FreightSearchQueryToJson(FreightSearchQuery instance) =>
    <String, dynamic>{
      'originCityHash': instance.originCityHash,
      'originRadiusInKM': instance.originRadiusInKM,
      'destinationCityHash': instance.destinationCityHash,
      'destinationRadiusInKM': instance.destinationRadiusInKM,
      'antt': instance.antt,
      'position': LatLng.toJson(instance.position),
    };

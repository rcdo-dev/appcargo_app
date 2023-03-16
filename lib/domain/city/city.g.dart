// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) {
  return City(
    hash: json['hash'] as String,
    name: json['name'] as String,
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'hash': instance.hash,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

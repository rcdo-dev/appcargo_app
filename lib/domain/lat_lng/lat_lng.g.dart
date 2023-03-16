// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lat_lng.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLng _$LatLngFromJson(Map<String, dynamic> json) {
  return LatLng(
    longitude: Converters.from(json['longitude']),
    latitude: Converters.from(json['latitude']),
  );
}

Map<String, dynamic> _$LatLngToJson(LatLng instance) => <String, dynamic>{
      'latitude': double.parse(instance.latitude),
      'longitude': double.parse(instance.longitude),
    };

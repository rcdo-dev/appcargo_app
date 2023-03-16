// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    json['instant'] as String,
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
    (json['accuracy'] as num)?.toDouble(),
    (json['batteryLevel'] as num)?.toDouble(),
    (json['odometer'] as num)?.toDouble(),
    json['isMoving'] as bool,
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'instant': genericStringCleaner(instance.instant),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'accuracy': instance.accuracy,
      'batteryLevel': instance.batteryLevel,
      'odometer': instance.odometer,
      'isMoving': instance.isMoving,
    };

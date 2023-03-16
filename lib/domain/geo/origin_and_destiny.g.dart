// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'origin_and_destiny.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OriginAndDestiny _$OriginAndDestinyFromJson(Map<String, dynamic> json) {
  return OriginAndDestiny()
    ..origin = json['origin'] == null
        ? null
        : LatLng.fromJson(json['origin'] as Map<String, dynamic>)
    ..destiny = json['destiny'] == null
        ? null
        : LatLng.fromJson(json['destiny'] as Map<String, dynamic>);
}

Map<String, dynamic> _$OriginAndDestinyToJson(OriginAndDestiny instance) =>
    <String, dynamic>{
      'origin': LatLng.toJson(instance.origin),
      'destiny': LatLng.toJson(instance.destiny),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'truck_photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TruckPhoto _$TruckPhotoFromJson(Map<String, dynamic> json) {
  return TruckPhoto(
    type: TruckPhotoType._fromJson(json['type'] as String),
    photoUrl: json['photoUrl'] as String,
  );
}

Map<String, dynamic> _$TruckPhotoToJson(TruckPhoto instance) =>
    <String, dynamic>{
      'type': TruckPhotoType._toJson(instance.type),
      'photoUrl': instance.photoUrl,
    };

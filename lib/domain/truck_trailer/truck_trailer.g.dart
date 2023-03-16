// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'truck_trailer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TruckTrailer _$TruckTrailerFromJson(Map<String, dynamic> json) {
  return TruckTrailer(
    plate: json['plate'] as String,
    renavam: json['renavam'] as String,
    vin: json['vin'] as String,
    extras: json['extras'] as String,
    documentationPhotoUrl: json['documentationPhotoUrl'] as String,
    hash: json['hash'] as String,
  );
}

Map<String, dynamic> _$TruckTrailerToJson(TruckTrailer instance) =>
    <String, dynamic>{
      'plate': genericStringCleaner(instance.plate),
      'renavam': genericStringCleaner(instance.renavam),
      'vin': genericStringCleaner(instance.vin),
      'extras': instance.extras,
      'documentationPhotoUrl': instance.documentationPhotoUrl,
      'hash': instance.hash,
    };

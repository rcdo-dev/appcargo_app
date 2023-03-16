// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) {
  return ApiError(
    json['code'] as String,
    details: json['details'] as String,
    extras: mapFromJson(json['extras']),
  );
}

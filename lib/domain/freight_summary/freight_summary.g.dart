// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freight_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreightSummary _$FreightSummaryFromJson(Map<String, dynamic> json) {
  return FreightSummary(
    code: json['code'] as String,
    photoUrl: json['photoUrl'] as String,
    distanceInMeters: json['distanceInMeters'] as String,
    freightCoContact: json['freightCoContact'] as String,
    from: AddressSummary.fromJson(json['from'] as Map<String, dynamic>),
    hash: json['hash'] as String,
    to: AddressSummary.fromJson(json['to'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FreightSummaryToJson(FreightSummary instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'photoUrl': instance.photoUrl,
      'code': instance.code,
      'from': AddressSummary.toJson(instance.from),
      'to': AddressSummary.toJson(instance.to),
      'distanceInMeters': instance.distanceInMeters,
      'freightCoContact': instance.freightCoContact,
    };

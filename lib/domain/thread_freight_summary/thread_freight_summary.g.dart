// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_freight_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThreadFreightSummary _$ThreadFreightSummaryFromJson(Map<String, dynamic> json) {
  return ThreadFreightSummary(
    hash: json['hash'] as String,
    from: AddressSummary.fromJson(json['from'] as Map<String, dynamic>),
    to: AddressSummary.fromJson(json['to'] as Map<String, dynamic>),
    distanceInMeters: json['distanceInMeters'] as int,
    creationDate: json['creationDate'] as String,
    errors: json['errors'] as List<dynamic>,
  );
}

Map<String, dynamic> _$ThreadFreightSummaryToJson(ThreadFreightSummary instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'from': AddressSummary.toJson(instance.from),
      'to': AddressSummary.toJson(instance.to),
      'distanceInMeters': instance.distanceInMeters,
      'creationDate': instance.creationDate,
      'errors': instance.errors,
    };

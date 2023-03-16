// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplaintSummary _$ComplaintSummaryFromJson(Map<String, dynamic> json) {
  return ComplaintSummary(
    hash: json['hash'] as String,
    code: json['code'] as String,
    subject: json['subject'] as String,
  );
}

Map<String, dynamic> _$ComplaintSummaryToJson(ComplaintSummary instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'code': instance.code,
      'subject': instance.subject,
    };

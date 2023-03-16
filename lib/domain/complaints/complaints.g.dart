// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaints.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Complaints _$ComplaintsFromJson(Map<String, dynamic> json) {
  return Complaints(
    closed: (json['closed'] as List)
        ?.map((e) => e == null
            ? null
            : ComplaintSummary.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    open: (json['open'] as List)
        ?.map((e) => e == null
            ? null
            : ComplaintDetails.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ComplaintsToJson(Complaints instance) =>
    <String, dynamic>{
      'open': instance.open,
      'closed': instance.closed,
    };

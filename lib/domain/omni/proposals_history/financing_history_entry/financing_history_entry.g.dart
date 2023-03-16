// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financing_history_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinancingHistoryEntry _$FinancingHistoryEntryFromJson(
    Map<String, dynamic> json) {
  return FinancingHistoryEntry()
    ..status = json['status'] as String
    ..statusText = json['statusText'] as String
    ..date = json['date'] as String;
}

Map<String, dynamic> _$FinancingHistoryEntryToJson(
        FinancingHistoryEntry instance) =>
    <String, dynamic>{
      'status': instance.status,
      'statusText': instance.statusText,
      'date': instance.date,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freight_company_summary_pageable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreightCompanySummaryPageable _$FreightCompanySummaryPageableFromJson(
    Map<String, dynamic> json) {
  return FreightCompanySummaryPageable(
    data: FreightCompanySummaryPageable.freightCompanyListFromJson(
        json['data'] as List),
    hasNext: json['hasNext'] as bool,
    hasPrevious: json['hasPrevious'] as bool,
    recordsFiltered: json['recordsFiltered'] as int,
    recordsTotal: json['recordsTotal'] as int,
  );
}

Map<String, dynamic> _$FreightCompanySummaryPageableToJson(
        FreightCompanySummaryPageable instance) =>
    <String, dynamic>{
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
      'hasNext': instance.hasNext,
      'hasPrevious': instance.hasPrevious,
      'data':
          FreightCompanySummaryPageable.freightCompanyListToJson(instance.data),
    };

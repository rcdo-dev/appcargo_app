// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_freightco_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagedFreightCoSummary _$PagedFreightCoSummaryFromJson(
    Map<String, dynamic> json) {
  return PagedFreightCoSummary()
    ..recordsTotal = json['recordsTotal'] as int
    ..recordsFiltered = json['recordsFiltered'] as int
    ..hasNext = json['hasNext'] as bool
    ..hasPrevious = json['hasPrevious'] as bool
    ..data = (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : FreightCompanySummary.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

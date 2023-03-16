// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vouchers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vouchers _$VouchersFromJson(Map<String, dynamic> json) {
  return Vouchers(
    vouchers: (json['vouchers'] as List)
        ?.map((e) => e == null
            ? null
            : VoucherSummary.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    overdue: (json['overdue'] as List)
        ?.map((e) => e == null
            ? null
            : VoucherSummary.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VouchersToJson(Vouchers instance) => <String, dynamic>{
      'vouchers': instance.vouchers,
      'overdue': instance.overdue,
    };

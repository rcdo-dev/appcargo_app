// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherSummary _$VoucherSummaryFromJson(Map<String, dynamic> json) {
  return VoucherSummary(
    hash: json['hash'] as String,
    imageUrl: json['imageUrl'] as String,
    voucherOwnershipHash: json['voucherOwnershipHash'] as String,
  );
}

Map<String, dynamic> _$VoucherSummaryToJson(VoucherSummary instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'imageUrl': instance.imageUrl,
      'voucherOwnershipHash': instance.voucherOwnershipHash,
    };

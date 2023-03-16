// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherDetails _$VoucherDetailsFromJson(Map<String, dynamic> json) {
  return VoucherDetails(
    hash: json['hash'] as String,
    voucherOwnershipHash: json['voucherOwnershipHash'] as String,
    description: json['description'] as String,
    name: json['name'] as String,
    imageUrl: json['imageUrl'] as String,
    canAcquire: json['canAcquire'] as bool,
  );
}

Map<String, dynamic> _$VoucherDetailsToJson(VoucherDetails instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'voucherOwnershipHash': instance.voucherOwnershipHash,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'name': instance.name,
      'canAcquire': instance.canAcquire,
    };

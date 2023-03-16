import 'package:json_annotation/json_annotation.dart';

part 'voucher_details.g.dart';

@JsonSerializable()
class VoucherDetails {
  String hash;
  String voucherOwnershipHash;
  String imageUrl;
  String description;
  String name;
  bool canAcquire;

  VoucherDetails({
    this.hash,
    this.voucherOwnershipHash,
    this.description,
    this.name,
    this.imageUrl,
    this.canAcquire,
  });

  static Map<String, dynamic> toJson(VoucherDetails voucherDetails) {
    return _$VoucherDetailsToJson(voucherDetails);
  }

  static VoucherDetails fromJson(Map<String, dynamic> json) {
    return _$VoucherDetailsFromJson(json);
  }
}

import 'package:json_annotation/json_annotation.dart';

part 'voucher_summary.g.dart';

@JsonSerializable()
class VoucherSummary {
  String hash;
  String imageUrl;
  String voucherOwnershipHash;

  VoucherSummary({
    this.hash,
    this.imageUrl,
    this.voucherOwnershipHash,
  });

  String toJson(VoucherSummary voucherSummary) {
    return _$VoucherSummaryToJson(voucherSummary).toString();
  }

  factory VoucherSummary.fromJson(Map<String, dynamic> json) {
    return _$VoucherSummaryFromJson(json);
  }
}

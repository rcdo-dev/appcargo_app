import 'package:app_cargo/domain/voucher_summary/voucher_summary.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vouchers.g.dart';

@JsonSerializable()
class Vouchers {
  List<VoucherSummary> vouchers;
  List<VoucherSummary> overdue;

  Vouchers({
    this.vouchers,
    this.overdue,
  });

  static Map<String, dynamic> toJson(Vouchers vouchers) {
    return _$VouchersToJson(vouchers);
  }

  static Vouchers fromJson(Map<String, dynamic> json) {
    return _$VouchersFromJson(json);
  }
}

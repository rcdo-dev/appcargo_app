import 'package:app_cargo/domain/referrals/referrals.dart';
import 'package:app_cargo/domain/voucher_details/voucher_details.dart';
import 'package:app_cargo/domain/voucher_summary/voucher_summary.dart';
import 'package:app_cargo/http/app_cargo_client.dart';

List<VoucherSummary> _mapToVoucherSummary(Map<String, dynamic> json) {
  List<dynamic> _vouchers = json["vouchers"] as List<dynamic>;
  List<VoucherSummary> _vouchersSummary = new List<VoucherSummary>();
  for (Map<String, dynamic> _voucher in _vouchers) {
    _vouchersSummary.add(VoucherSummary.fromJson(_voucher));
  }
  return _vouchersSummary;
}

VoucherDetails _mapToVoucherDetails(Map<String, dynamic> json) {
  return VoucherDetails.fromJson(json);
}

class VouchersService {
  AppCargoClient _dioClient;

  VouchersService(this._dioClient);

  Future<List<VoucherSummary>> getVouchersHighlights() {
    return this
        ._dioClient
        .get("/v1/vouchers/highlights", _mapToVoucherSummary)
        .catchError((e) {
      throw e;
    });
  }

  Future<VoucherDetails> getVoucherDetails(String hash) {
    return this
        ._dioClient
        .get("/v1/vouchers/$hash", _mapToVoucherDetails)
        .catchError((e) {
      throw e;
    });
  }

  Future<VoucherDetails> getVoucherOwnershipDetails(String hash) {
    return this
        ._dioClient
        .get("/v1/vouchers/$hash/ownership", _mapToVoucherDetails)
        .catchError((e) {
      throw e;
    });
  }

  Future<void> acquireVoucher(VoucherDetails voucherDetails) {
    return this
        ._dioClient
        .post("/v1/vouchers/${voucherDetails.hash}/acquire", null)
        .catchError((e) {
      throw e;
    });
  }

  Future<void> validateDriverQrCode(String voucherHash) {
    return this
        ._dioClient
        .post("/v1/vouchers/$voucherHash/validate", null)
        .catchError((e) {
      throw e;
    });
  }
}

import 'package:app_cargo/db/voucher_details_dao.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/referrals/referrals.dart';
import 'package:app_cargo/domain/voucher_details/voucher_details.dart';
import 'package:app_cargo/domain/voucher_summary/voucher_summary.dart';
import 'package:app_cargo/services/vouchers_service/vouchers_service.dart';

String hash = "72543da6-b7ad-11e9-a2a3-2a2ae2dbce4";
VoucherDetails defaultVoucherDetailsCantAcquire = new VoucherDetails(
    imageUrl:
        "https://thumbs.dreamstime.com/b/cartaz-real%C3%ADstico-da-propaganda-dos-produtos-lavagem-de-carros-com-autom%C3%B3vel-124557570.jpg",
    hash: hash,
    name: "Cupom do bom",
    description: "Cupom do bom com descontos top",
    canAcquire: false);

VoucherDetails defaultVoucherDetailsCanAcquire = new VoucherDetails(
    imageUrl:
        "https://thumbs.dreamstime.com/b/cartaz-real%C3%ADstico-da-propaganda-dos-produtos-lavagem-de-carros-com-autom%C3%B3vel-124557570.jpg",
    hash: hash,
    name: "Cupom do bom",
    description: "Cupom do bom com descontos top",
    canAcquire: true);

VoucherSummary defaultVoucherSummary = new VoucherSummary(
  hash: hash,
  imageUrl:
      "https://thumbs.dreamstime.com/b/cartaz-real%C3%ADstico-da-propaganda-dos-produtos-lavagem-de-carros-com-autom%C3%B3vel-124557570.jpg",
);

class VouchersMockService implements VouchersService {
  final VoucherDetailsDAO _vouchersDetailsDAO =
      DIContainer().get<VoucherDetailsDAO>();

  @override
  Future<void> acquireVoucher(VoucherDetails voucherDetails) {
    return Future.delayed(Duration(seconds: 1));
  }

  @override
  Future<VoucherDetails> getVoucherDetails(String hash) {
    return _vouchersDetailsDAO.querySingleRow(hash).then((value) {
      if (value != null) {
        return value;
      } else {
        return Future.delayed(
            Duration(seconds: 1), () => defaultVoucherDetailsCanAcquire);
      }
    });
  }

  @override
  Future<List<VoucherSummary>> getVouchersHighlights() {
    return Future.delayed(
      Duration(seconds: 1),
      () =>
          [defaultVoucherSummary, defaultVoucherSummary, defaultVoucherSummary],
    );
  }

  @override
  Future<bool> validateDriverQrCode(String qrCode) {
    // TODO: implement validateDriverQrCode
    return null;
  }

  @override
  Future<VoucherDetails> getVoucherOwnershipDetails(String hash) {
    // TODO: implement getVoucherOwnershipDetails
    return null;
  }
}

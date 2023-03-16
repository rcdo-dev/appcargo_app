import 'package:app_cargo/domain/referrals/referrals.dart';
import 'package:app_cargo/http/app_cargo_client.dart';

class ClubService {
  AppCargoClient _dioClient;

  ClubService(this._dioClient);

  Future<dynamic> sendReferences(Referrals referrals) {
    return this
        ._dioClient
        .post("/v1/club/invite", null, data: Referrals.toJson(referrals));
  }
}

import 'package:app_cargo/http/app_cargo_client.dart';

class RecoverPasswordService {
  AppCargoClient _dioClient;

  RecoverPasswordService(this._dioClient);

  Future<void> requestRecoverPassword(String email) {
    return this._dioClient.post("/v1/doRecoverPassword", null,
        data: {'login': email}).catchError((e) {
      throw e;
    });
  }
}

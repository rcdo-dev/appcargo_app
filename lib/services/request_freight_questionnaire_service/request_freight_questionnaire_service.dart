import 'package:app_cargo/domain/request_freight_questionnaire/request_freight_questionnaire.dart';
import 'package:app_cargo/http/app_cargo_client.dart';

class RequestFreightQuestionnaireService {
  AppCargoClient _appCargoClient;

  RequestFreightQuestionnaireService(this._appCargoClient);

  Future<dynamic> sendQuestionnaireData(
    RequestFreightQuestionnaire freightQuestionnaire,
  ) async {
    return _appCargoClient
        .post(
      "/v1/freightRequest",
      null,
      data: RequestFreightQuestionnaire.toJson(freightQuestionnaire),
    )
        .catchError(
      (err) {
        throw err;
      },
    );
  }
}

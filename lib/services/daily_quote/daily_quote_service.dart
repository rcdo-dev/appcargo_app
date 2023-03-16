import 'package:app_cargo/domain/daily_quote/daily_quote.dart';
import 'package:app_cargo/http/app_cargo_client.dart';

DailyQuote _mapToDailyQuote(Map<String, dynamic> json) {
  return DailyQuote.fromJson(json);
}

class DailyQuoteService {

  AppCargoClient _dioClient;

  DailyQuoteService(this._dioClient);

  Future<DailyQuote> getDailyQuote() {
    return this
        ._dioClient
        .get("/v1/getDailyQuote", _mapToDailyQuote)
        .catchError((e) {
      throw e;
    });
  }

}
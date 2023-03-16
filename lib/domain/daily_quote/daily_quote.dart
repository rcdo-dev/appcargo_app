
part 'daily_quote.g.dart';

class DailyQuote {

  String quote;

  DailyQuote({this.quote});

  String toJson(DailyQuote dailyQuote) {
    return _$DailyQuoteToJson(dailyQuote).toString();
  }

  factory DailyQuote.fromJson(Map<String, dynamic> json) {
    return _$DailyQuoteFromJson(json);
  }

}
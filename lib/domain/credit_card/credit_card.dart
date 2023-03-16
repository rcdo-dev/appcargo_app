import 'package:json_annotation/json_annotation.dart';

part 'credit_card.g.dart';

@JsonSerializable()
class CreditCard {
  String holderName;
  String number;
  String securityCode;
  String validity;

  CreditCard({this.holderName, this.number, this.securityCode, this.validity});

  String toJson(CreditCard creditCard) {
    return _$CreditCardToJson(creditCard).toString();
  }

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return _$CreditCardFromJson(json);
  }
}

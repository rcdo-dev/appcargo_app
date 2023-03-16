import 'package:json_annotation/json_annotation.dart';

part 'bank_data.g.dart';

@JsonSerializable()
class BankData {
  String bank;
  String agency;
  String account;

  BankData({this.account, this.agency, this.bank});

  static Map<String, dynamic> toJson(BankData bankData) {
    return _$BankDataToJson(bankData);
  }

  static BankData fromJson(Map<String, dynamic> json) {
    if(json != null)
      return _$BankDataFromJson(json);
    else
      return null;
  }
}

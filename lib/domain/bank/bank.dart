import 'package:json_annotation/json_annotation.dart';

part 'bank.g.dart';

@JsonSerializable()
class Bank {
  String name;
  String code;

  Bank({
    this.name,
    this.code,
  });

  static Map<String, dynamic> toJson(Bank bank) {
    if (bank != null)
      return _$BankToJson(bank);
    else
      return null;
  }

  static Bank fromJson(Map<String, dynamic> json) {
    if (json != null)
      return _$BankFromJson(json);
    else
      return null;
  }

  @override
  bool operator ==(other) {
    return this.code == (other.code);
  }
}

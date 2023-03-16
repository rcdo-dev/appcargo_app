// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankData _$BankDataFromJson(Map<String, dynamic> json) {
  return BankData(
    account: json['account'] as String,
    agency: json['agency'] as String,
    bank: json['bank'] as String,
  );
}

Map<String, dynamic> _$BankDataToJson(BankData instance) => <String, dynamic>{
      'bank': instance.bank,
      'agency': instance.agency,
      'account': instance.account,
    };

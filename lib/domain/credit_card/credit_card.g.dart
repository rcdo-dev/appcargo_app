// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCard _$CreditCardFromJson(Map<String, dynamic> json) {
  return CreditCard(
    holderName: json['holderName'] as String,
    number: json['number'] as String,
    securityCode: json['securityCode'] as String,
    validity: json['validity'] as String,
  );
}

Map<String, dynamic> _$CreditCardToJson(CreditCard instance) =>
    <String, dynamic>{
      'holderName': instance.holderName,
      'number': instance.number,
      'securityCode': instance.securityCode,
      'validity': instance.validity,
    };

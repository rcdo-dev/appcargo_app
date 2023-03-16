// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'omni_financing_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OmniFinancingOptions _$OmniFinancingOptionsFromJson(Map<String, dynamic> json) {
  return OmniFinancingOptions()
    ..friendlyHash = json['friendlyHash'] as String
    ..totalPrice = (json['totalPrice'] as num)?.toDouble()
    ..installments = json['installments'] as int
    ..financedAmount = (json['financedAmount'] as num)?.toDouble()
    ..installmentValue = (json['installmentValue'] as num)?.toDouble()
    ..rate = (json['rate'] as num)?.toDouble()
    ..inputValue = (json['inputValue'] as num)?.toDouble()
    ..netValue = (json['netValue'] as num)?.toDouble()
    ..sircofValue = (json['sircofValue'] as num)?.toDouble()
    ..tcValue = (json['tcValue'] as num)?.toDouble()
    ..dvValue = (json['dvValue'] as num)?.toDouble()
    ..iofValue = (json['iofValue'] as num)?.toDouble();
}

Map<String, dynamic> _$OmniFinancingOptionsToJson(
        OmniFinancingOptions instance) =>
    <String, dynamic>{
      'friendlyHash': instance.friendlyHash,
      'totalPrice': instance.totalPrice,
      'installments': instance.installments,
      'financedAmount': instance.financedAmount,
      'installmentValue': instance.installmentValue,
      'rate': instance.rate,
      'inputValue': instance.inputValue,
      'netValue': instance.netValue,
      'sircofValue': instance.sircofValue,
      'tcValue': instance.tcValue,
      'dvValue': instance.dvValue,
      'iofValue': instance.iofValue,
    };

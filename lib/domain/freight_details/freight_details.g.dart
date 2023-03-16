// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freight_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreightDetails _$FreightDetailsFromJson(Map<String, dynamic> json) {
  return FreightDetails(
    code: json['code'] as String,
    hash: json['hash'] as String,
    to: AddressSummary.fromJson(json['to'] as Map<String, dynamic>),
    from: AddressSummary.fromJson(json['from'] as Map<String, dynamic>),
    freightCoContact: json['freightCoContact'] as String,
    distanceInMeters: Converters.from(json['distanceInMeters']),
    freightCompany: FreightCompanySummary.fromJson(
        json['freightCompany'] as Map<String, dynamic>),
    observation: json['observation'] as String,
    paymentMethod:
        FreightPaymentMethodType.fromJson(json['paymentMethod'] as String),
    product: json['product'] as String,
    species: json['species'] as String,
    termInDays: Converters.from(json['termInDays']),
    tollInCents: Converters.from(json['tollInCents']),
    valueInCents: Converters.from(json['valueInCents']),
    status: FreightStatus.fromJson(json['status'] as String),
    weightInGrams: Converters.from(json['weightInGrams']),
  );
}

Map<String, dynamic> _$FreightDetailsToJson(FreightDetails instance) =>
    <String, dynamic>{
      'from': AddressSummary.toJson(instance.from),
      'to': AddressSummary.toJson(instance.to),
      'code': instance.code,
      'hash': instance.hash,
      'distanceInMeters': int.parse(instance.distanceInMeters),
      'freightCoContact': instance.freightCoContact,
      'weightInGrams': int.parse(instance.weightInGrams),
      'valueInCents': int.parse(instance.valueInCents),
      'tollInCents': int.parse(instance.tollInCents),
      'termInDays': int.parse(instance.termInDays),
      'paymentMethod': FreightPaymentMethodType.toJson(instance.paymentMethod),
      'status': FreightStatus.toJson(instance.status),
      'product': instance.product,
      'species': instance.species,
      'observation': instance.observation,
      'freightCompany': FreightCompanySummary.toJson(instance.freightCompany),
    };

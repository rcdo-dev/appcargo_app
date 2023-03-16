// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freight_company_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreightCompanySummary _$FreightCompanySummaryFromJson(
    Map<String, dynamic> json) {
  return FreightCompanySummary(
    rating: json['rating'] as int,
    contact: json['contact'] as String,
    address: AddressSummary.fromJson(json['address'] as Map<String, dynamic>),
    hash: json['hash'] as String,
    name: json['name'] as String,
    photo: json['photo'] as String,
    positionInRanking: json['positionInRanking'] as int,
    accessCredentialHash: json['accessCredentialHash'] as String,
  );
}

Map<String, dynamic> _$FreightCompanySummaryToJson(
        FreightCompanySummary instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'accessCredentialHash': instance.accessCredentialHash,
      'name': instance.name,
      'photo': instance.photo,
      'rating': instance.rating,
      'positionInRanking': instance.positionInRanking,
      'contact': instance.contact,
      'address': AddressSummary.toJson(instance.address),
    };

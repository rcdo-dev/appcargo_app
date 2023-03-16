// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freight_company_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreightCompanyDetail _$FreightCompanyDetailFromJson(Map<String, dynamic> json) {
  return FreightCompanyDetail(
    address: json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    contact: json['contact'] as String,
    rating: json['rating'] as int,
    highlightedFeedback: (json['highlightedFeedback'] as List)
        ?.map((e) => e == null
            ? null
            : FreightCompanyFeedback.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    rankingPosition: json['rankingPosition'] as int,
    accessCredentialHash: json['accessCredentialHash'] as String,
    name: json['name'] as String,
    hash: json['hash'] as String,
    photo: json['photo'] as String,
  );
}

Map<String, dynamic> _$FreightCompanyDetailToJson(
        FreightCompanyDetail instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'accessCredentialHash': instance.accessCredentialHash,
      'name': instance.name,
      'rating': instance.rating,
      'contact': instance.contact,
      'rankingPosition': instance.rankingPosition,
      'address': instance.address,
      'highlightedFeedback': instance.highlightedFeedback,
      'photo': instance.photo,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freight_company_feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreightCompanyFeedback _$FreightCompanyFeedbackFromJson(
    Map<String, dynamic> json) {
  return FreightCompanyFeedback(
    driver: json['driver'] as String,
    description: json['description'] as String,
    rating: json['rating'] as int,
  );
}

Map<String, dynamic> _$FreightCompanyFeedbackToJson(
        FreightCompanyFeedback instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'description': instance.description,
      'driver': instance.driver,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_freight_questionnaire.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestFreightQuestionnaire _$RequestFreightQuestionnaireFromJson(
    Map<String, dynamic> json) {
  return RequestFreightQuestionnaire()
    ..truckType = json['truckType'] as String
    ..cityFriendlyHash = json['cityFriendlyHash'] as String
    ..destinationCityHash = json['destinationCityHash'] as String
    ..trailerType = json['trailerType'] as String
    ..weightCapacity = json['weightCapacity'] as int;
}

Map<String, dynamic> _$RequestFreightQuestionnaireToJson(
        RequestFreightQuestionnaire instance) =>
    <String, dynamic>{
      'truckType': instance.truckType,
      'cityFriendlyHash': instance.cityFriendlyHash,
      'destinationCityHash': instance.destinationCityHash,
      'trailerType': instance.trailerType,
      'weightCapacity': instance.weightCapacity,
    };

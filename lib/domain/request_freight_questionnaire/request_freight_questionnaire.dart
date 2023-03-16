part 'request_freight_questionnaire.g.dart';

class RequestFreightQuestionnaire {
  String truckType;
  String cityFriendlyHash;
  String destinationCityHash;
  String trailerType;
  int weightCapacity;

  RequestFreightQuestionnaire({
    this.truckType,
    this.cityFriendlyHash,
    this.destinationCityHash,
    this.trailerType,
    this.weightCapacity,
  });

  static Map<String, dynamic> toJson(RequestFreightQuestionnaire instance) {
    return _$RequestFreightQuestionnaireToJson(instance);
  }

  static RequestFreightQuestionnaire fromJson(Map<String, dynamic> json) {
    return _$RequestFreightQuestionnaireFromJson(json);
  }
}

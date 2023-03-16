import 'package:json_annotation/json_annotation.dart';

part 'freight_company_feedback.g.dart';

@JsonSerializable()
class FreightCompanyFeedback {
  int rating;
  String description;

  /// Feedback's driver name
  String driver;

  FreightCompanyFeedback({
    this.driver,
    this.description,
    this.rating,
  });

  static Map<String, dynamic> toJson(
      FreightCompanyFeedback freightCompanyFeedback) {
    return _$FreightCompanyFeedbackToJson(freightCompanyFeedback);
  }

  static FreightCompanyFeedback fromJson(Map<String, dynamic> json) {
    return _$FreightCompanyFeedbackFromJson(json);
  }
}

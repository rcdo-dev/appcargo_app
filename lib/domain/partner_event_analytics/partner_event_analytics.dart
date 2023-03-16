import 'package:json_annotation/json_annotation.dart';

part 'partner_event_analytics.g.dart';

@JsonSerializable()
class PartnerEventAnalytics {

  String element;
  String elementHash;


  PartnerEventAnalytics(this.element, this.elementHash);

  static Map<String, dynamic> toJson(PartnerEventAnalytics instance) {
    return _$PartnerEventAnalyticsToJson(instance);
  }

  static PartnerEventAnalytics fromJson(Map<String, dynamic> json) {
    return _$PartnerEventAnalyticsFromJson(json);
  }

}
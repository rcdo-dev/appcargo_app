import 'package:json_annotation/json_annotation.dart';

part 'notification_configuration.g.dart';

@JsonSerializable()
class NotificationConfiguration {
  bool notifyNearbyRequests;
  bool notifyCompanyContact;
  bool notifyCargoClubOffers;
  bool notifyNewRequests;

  NotificationConfiguration({
    this.notifyCargoClubOffers,
    this.notifyCompanyContact,
    this.notifyNearbyRequests,
    this.notifyNewRequests,
  });

  static Map<String, dynamic> toJson(
      NotificationConfiguration notificationConfiguration) {
    return _$NotificationConfigurationToJson(notificationConfiguration);
  }

  static NotificationConfiguration fromJson(Map<String, dynamic> json) {
    return _$NotificationConfigurationFromJson(json);
  }
}

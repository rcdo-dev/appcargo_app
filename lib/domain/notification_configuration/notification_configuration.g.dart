// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationConfiguration _$NotificationConfigurationFromJson(
    Map<String, dynamic> json) {
  return NotificationConfiguration(
    notifyCargoClubOffers: json['notifyCargoClubOffers'] as bool,
    notifyCompanyContact: json['notifyCompanyContact'] as bool,
    notifyNearbyRequests: json['notifyNearbyRequests'] as bool,
    notifyNewRequests: json['notifyNewRequests'] as bool,
  );
}

Map<String, dynamic> _$NotificationConfigurationToJson(
        NotificationConfiguration instance) =>
    <String, dynamic>{
      'notifyNearbyRequests': instance.notifyNearbyRequests,
      'notifyCompanyContact': instance.notifyCompanyContact,
      'notifyCargoClubOffers': instance.notifyCargoClubOffers,
      'notifyNewRequests': instance.notifyNewRequests,
    };

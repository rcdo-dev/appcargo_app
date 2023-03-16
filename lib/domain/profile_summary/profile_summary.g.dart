// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileSummary _$ProfileSummaryFromJson(Map<String, dynamic> json) {
  return ProfileSummary(
    current: FreightDetails.fromJson(json['current'] as Map<String, dynamic>),
    proposals:
        ProfileSummary.fromJsonFreightDetailsList(json['proposals'] as List),
    contact:
        DriverContactData.fromJson(json['contact'] as Map<String, dynamic>),
    declineReasonsListLastUpdate:
        json['declineReasonsListLastUpdate'] as String,
    voucherOwnershipLastUpdate: json['voucherOwnershipLastUpdate'] as String,
    emergency:
        DriverEmergencyData.fromJson(json['emergency'] as Map<String, dynamic>),
    social: DriverSocialData.fromJson(json['social'] as Map<String, dynamic>),
    personal:
        DriverPersonalData.fromJson(json['personal'] as Map<String, dynamic>),
    vehicle: VehicleData.fromJson(json['vehicle'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProfileSummaryToJson(ProfileSummary instance) =>
    <String, dynamic>{
      'proposals': instance.proposals,
      'current': FreightDetails.toJson(instance.current),
      'vehicle': VehicleData.toJson(instance.vehicle),
      'contact': DriverContactData.toJson(instance.contact),
      'personal': DriverPersonalData.toJson(instance.personal),
      'social': DriverSocialData.toJson(instance.social),
      'emergency': DriverEmergencyData.toJson(instance.emergency),
      'declineReasonsListLastUpdate': instance.declineReasonsListLastUpdate,
      'voucherOwnershipLastUpdate': instance.voucherOwnershipLastUpdate,
    };

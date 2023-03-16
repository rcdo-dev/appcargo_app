// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_contact_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverContactUpdate _$DriverContactUpdateFromJson(Map<String, dynamic> json) {
  return DriverContactUpdate(
    contact:
        DriverContactData.fromJson(json['contact'] as Map<String, dynamic>),
    emergency:
        DriverEmergencyData.fromJson(json['emergency'] as Map<String, dynamic>),
    social: DriverSocialData.fromJson(json['social'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DriverContactUpdateToJson(
        DriverContactUpdate instance) =>
    <String, dynamic>{
      'contact': DriverContactData.toJson(instance.contact),
      'social': DriverSocialData.toJson(instance.social),
      'emergency': DriverEmergencyData.toJson(instance.emergency),
    };

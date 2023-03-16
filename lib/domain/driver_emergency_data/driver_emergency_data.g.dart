// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_emergency_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverEmergencyData _$DriverEmergencyDataFromJson(Map<String, dynamic> json) {
  return DriverEmergencyData(
    cellNumber: json['cellNumber'] as String,
    name: json['name'] as String,
    relation: json['relation'] as String,
  );
}

Map<String, dynamic> _$DriverEmergencyDataToJson(
        DriverEmergencyData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'relation': instance.relation,
      'cellNumber': genericStringCleaner(instance.cellNumber),
    };

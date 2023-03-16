// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulation_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimulationData _$SimulationDataFromJson(Map<String, dynamic> json) {
  return SimulationData()
    ..friendlyHash = json['friendlyHash'] as String
    ..licensePlate = json['licensePlate'] as String
    ..requestDate = json['requestDate'] as String
    ..statusText = json['statusText'] as String
    ..status = json['status'] as String;
}

Map<String, dynamic> _$SimulationDataToJson(SimulationData instance) =>
    <String, dynamic>{
      'friendlyHash': instance.friendlyHash,
      'licensePlate': instance.licensePlate,
      'requestDate': instance.requestDate,
      'statusText': instance.statusText,
      'status': instance.status,
    };

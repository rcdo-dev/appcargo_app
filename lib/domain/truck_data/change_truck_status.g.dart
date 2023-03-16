// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_truck_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeTruckStatus _$ChangeTruckStatusFromJson(Map<String, dynamic> json) {
  return ChangeTruckStatus(
    status: TruckStatus.fromJson(json['status'] as String),
    data: ChangeTruckStatusData.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ChangeTruckStatusToJson(ChangeTruckStatus instance) =>
    <String, dynamic>{
      'status': TruckStatus.toJson(instance.status),
      'data': ChangeTruckStatusData.toJson(instance.data),
    };

ChangeTruckStatusData _$ChangeTruckStatusDataFromJson(
    Map<String, dynamic> json) {
  return ChangeTruckStatusData(
    notifyNewRequests: json['notifyNewRequests'] as bool,
    howLong: json['howLong'] as int,
    cityHash: json['cityHash'] as String,
  );
}

Map<String, dynamic> _$ChangeTruckStatusDataToJson(
        ChangeTruckStatusData instance) =>
    <String, dynamic>{
      'cityHash': instance.cityHash,
      'howLong': instance.howLong,
      'notifyNewRequests': instance.notifyNewRequests,
    };

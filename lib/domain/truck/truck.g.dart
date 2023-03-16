// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'truck.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Truck _$TruckFromJson(Map<String, dynamic> json) {
  return Truck(
    plate: json['plate'] as String,
    renavam: json['renavam'] as String,
    vin: json['vin'] as String,
    modelFipeId: json['modelFipeId'] as String,
    makeFipeId: json['makeFipeId'] as String,
    modelYear: json['modelYear'] as String,
  )
    ..truckType = json['truckType'] as String
    ..truckLoadType = json['truckLoadType'] as String;
}

Map<String, dynamic> _$TruckToJson(Truck instance) => <String, dynamic>{
      'plate': instance.plate,
      'renavam': instance.renavam,
      'vin': instance.vin,
      'modelFipeId': instance.modelFipeId,
      'makeFipeId': instance.makeFipeId,
      'modelYear': instance.modelYear,
      'truckType': instance.truckType,
      'truckLoadType': instance.truckLoadType,
    };

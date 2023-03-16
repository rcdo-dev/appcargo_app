// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleData _$VehicleDataFromJson(Map<String, dynamic> json) {
  return VehicleData(
    vin: json['vin'] as String,
    hasCarTracker: json['hasCarTracker'] as bool,
    hasCarLocator: json['hasCarLocator'] as bool,
    hasCarInsurance: json['hasCarInsurance'] as bool,
    hasPanicButton: json['hasPanicButton'] as bool,
    hasSiren: json['hasSiren'] as bool,
    hasDoorBlocker: json['hasDoorBlocker'] as bool,
    hasFifthWheelBlocker: json['hasFifthWheelBlocker'] as bool,
    hasTrailerBlocker: json['hasTrailerBlocker'] as bool,
    carTrackerName: json['carTrackerName'] as String,
    carLocatorName: json['carLocatorName'] as String,
    carInsuranceName: json['carInsuranceName'] as String,
    plate: json['plate'] as String,
    renavam: json['renavam'] as String,
    modelFipeId: json['modelFipeId'] as String,
    makeFipeId: json['makeFipeId'] as String,
    modelYear: json['modelYear'] as String,
    truckType: TruckType.fromJson(json['truckType'] as String),
    truckLoadType: TrailerType.fromJson(json['truckLoadType'] as String),
    trackerType: TrackerType.fromJson(json['trackerType'] as String),
    truckPhotos:
        TruckPhotos.fromJson(json['truckPhotos'] as Map<String, dynamic>),
    trailers: VehicleData.fromJsonTruckTrailers(json['trailers'] as List),
    axles: TruckAxles.fromJson(json['axles'] as String),
  );
}

Map<String, dynamic> _$VehicleDataToJson(VehicleData instance) =>
    <String, dynamic>{
      'plate': instance.plate,
      'renavam': instance.renavam,
      'vin': instance.vin,
      'modelFipeId': instance.modelFipeId,
      'makeFipeId': instance.makeFipeId,
      'modelYear': instance.modelYear,
      'truckLoadType': TrailerType.toJson(instance.truckLoadType),
      'truckType': TruckType.toJson(instance.truckType),
      'axles': TruckAxles.toJson(instance.axles),
      'hasPanicButton': instance.hasPanicButton,
      'hasSiren': instance.hasSiren,
      'hasDoorBlocker': instance.hasDoorBlocker,
      'hasFifthWheelBlocker': instance.hasFifthWheelBlocker,
      'hasTrailerBlocker': instance.hasTrailerBlocker,
      'hasCarTracker': instance.hasCarTracker,
      'carTrackerName': instance.carTrackerName,
      'hasCarInsurance': instance.hasCarInsurance,
      'carInsuranceName': instance.carInsuranceName,
      'hasCarLocator': instance.hasCarLocator,
      'carLocatorName': instance.carLocatorName,
      'trackerType': TrackerType.toJson(instance.trackerType),
      'truckPhotos': TruckPhotos.toJson(instance.truckPhotos),
      'trailers': VehicleData.toJsonTruckTrailers(instance.trailers),
    };

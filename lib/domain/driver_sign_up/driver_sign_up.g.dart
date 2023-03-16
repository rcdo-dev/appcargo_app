// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_sign_up.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverSignUp _$DriverSignUpFromJson(Map<String, dynamic> json) {
  return DriverSignUp(
    alias: json['alias'] as String,
    cellNumber: json['cellNumber'] as String,
    birthDate: dateFromJson(json['birthDate'] as String),
    nationalId: json['nationalId'] as String,
    email: json['email'] as String,
    truckType: TruckType.fromJson(json['truckType'] as String),
    password: json['password'] as String,
    trailerType: TrailerType.fromJson(json['trailerType'] as String),
    modelYearFipeId: json['modelYearFipeId'] as String,
    modelFipeId: json['modelFipeId'] as String,
    makeFipeId: json['makeFipeId'] as String,
    axles: TruckAxles.fromJson(json['axles'] as String),
    truckPlate: json['truckPlate'] as String,
    trailerPlate1: json['trailerPlate1'] as String,
    trailerPlate2: json['trailerPlate2'] as String,
    hasCarTracker: json['hasCarTracker'] as bool,
    hasMope: json['hasMope'] as bool,
    hasMEI: json['hasMEI'] as bool,
  );
}

Map<String, dynamic> _$DriverSignUpToJson(DriverSignUp instance) =>
    <String, dynamic>{
      'alias': instance.alias,
      'cellNumber': genericStringCleaner(instance.cellNumber),
      'birthDate': dateToJson(instance.birthDate),
      'nationalId': genericStringCleaner(instance.nationalId),
      'email': instance.email,
      'truckType': TruckType.toJson(instance.truckType),
      'password': instance.password,
      'trailerType': TrailerType.toJson(instance.trailerType),
      'modelFipeId': instance.modelFipeId,
      'modelYearFipeId': instance.modelYearFipeId,
      'makeFipeId': instance.makeFipeId,
      'axles': TruckAxles.toJson(instance.axles),
      'truckPlate': genericStringCleaner(instance.truckPlate),
      'trailerPlate1': genericStringCleaner(instance.trailerPlate1),
      'trailerPlate2': genericStringCleaner(instance.trailerPlate2),
      'hasCarTracker': instance.hasCarTracker,
      'hasMope': instance.hasMope,
      'hasMEI': instance.hasMEI,
    };

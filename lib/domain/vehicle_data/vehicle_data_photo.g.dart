// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_data_photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleDataPhoto _$VehicleDataPhotoFromJson(Map<String, dynamic> json) {
  return VehicleDataPhoto(
    truckLateralPhoto2: json['truckLateralPhoto2'] == null
        ? null
        : TruckPhoto.fromJson(
            json['truckLateralPhoto2'] as Map<String, dynamic>),
    truckRearPlatePhoto: json['truckRearPlatePhoto'] == null
        ? null
        : TruckPhoto.fromJson(
            json['truckRearPlatePhoto'] as Map<String, dynamic>),
    truckLateralPhoto1: json['truckLateralPhoto1'] == null
        ? null
        : TruckPhoto.fromJson(
            json['truckLateralPhoto1'] as Map<String, dynamic>),
    truckPlatePhoto: json['truckPlatePhoto'] == null
        ? null
        : TruckPhoto.fromJson(json['truckPlatePhoto'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VehicleDataPhotoToJson(VehicleDataPhoto instance) =>
    <String, dynamic>{
      'truckPlatePhoto': instance.truckPlatePhoto,
      'truckLateralPhoto1': instance.truckLateralPhoto1,
      'truckLateralPhoto2': instance.truckLateralPhoto2,
      'truckRearPlatePhoto': instance.truckRearPlatePhoto,
    };

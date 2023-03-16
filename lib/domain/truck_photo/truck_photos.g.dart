// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'truck_photos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TruckPhotos _$TruckPhotosFromJson(Map<String, dynamic> json) {
  return TruckPhotos(
    truckRearPlatePhoto: TruckPhoto.fromJson(
        json['truckRearPlatePhoto'] as Map<String, dynamic>),
    truckLateralPhoto1:
        TruckPhoto.fromJson(json['truckLateralPhoto1'] as Map<String, dynamic>),
    truckPlatePhoto:
        TruckPhoto.fromJson(json['truckPlatePhoto'] as Map<String, dynamic>),
    truckLateralPhoto2:
        TruckPhoto.fromJson(json['truckLateralPhoto2'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TruckPhotosToJson(TruckPhotos instance) =>
    <String, dynamic>{
      'truckPlatePhoto': TruckPhoto.toJson(instance.truckPlatePhoto),
      'truckLateralPhoto1': TruckPhoto.toJson(instance.truckLateralPhoto1),
      'truckLateralPhoto2': TruckPhoto.toJson(instance.truckLateralPhoto2),
      'truckRearPlatePhoto': TruckPhoto.toJson(instance.truckRearPlatePhoto),
    };

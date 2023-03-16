import 'dart:io';

import 'package:app_cargo/domain/truck_photo/truck_photo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'truck_photos.g.dart';

@JsonSerializable()
class TruckPhotos {
  @JsonKey(fromJson: TruckPhoto.fromJson, toJson: TruckPhoto.toJson)
  TruckPhoto truckPlatePhoto;
  @JsonKey(fromJson: TruckPhoto.fromJson, toJson: TruckPhoto.toJson)
  TruckPhoto truckLateralPhoto1;
  @JsonKey(fromJson: TruckPhoto.fromJson, toJson: TruckPhoto.toJson)
  TruckPhoto truckLateralPhoto2;
  @JsonKey(fromJson: TruckPhoto.fromJson, toJson: TruckPhoto.toJson)
  TruckPhoto truckRearPlatePhoto;

  TruckPhotos({
    this.truckRearPlatePhoto,
    this.truckLateralPhoto1,
    this.truckPlatePhoto,
    this.truckLateralPhoto2,
  });

  Map<String, File> get files => {
        if (null != truckPlatePhoto && null != truckPlatePhoto.photo)
          'truckPhotos.truckPlatePhoto.photo': truckPlatePhoto.photo,
        if (null != truckLateralPhoto1 && null != truckLateralPhoto1.photo)
          'truckPhotos.truckLateralPhoto1.photo': truckLateralPhoto1.photo,
        if (null != truckLateralPhoto2 && null != truckLateralPhoto2.photo)
          'truckPhotos.truckLateralPhoto2.photo': truckLateralPhoto2.photo,
        if (null != truckRearPlatePhoto && null != truckRearPlatePhoto.photo)
          'truckPhotos.truckRearPlatePhoto.photo': truckRearPlatePhoto.photo,
      };

  static Map<String, dynamic> toJson(TruckPhotos truckPhotos) {
    return _$TruckPhotosToJson(truckPhotos);
  }

  static TruckPhotos fromJson(Map<String, dynamic> json) {
    return _$TruckPhotosFromJson(json);
  }
}

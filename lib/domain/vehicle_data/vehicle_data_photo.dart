import 'package:app_cargo/domain/truck_photo/truck_photo.dart';
import 'package:app_cargo/domain/vehicle_data/vehicle_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_data_photo.g.dart';

@JsonSerializable()
class VehicleDataPhoto {
  TruckPhoto truckPlatePhoto;
  TruckPhoto truckLateralPhoto1;
  TruckPhoto truckLateralPhoto2;
  TruckPhoto truckRearPlatePhoto;

  VehicleDataPhoto({
    this.truckLateralPhoto2,
    this.truckRearPlatePhoto,
    this.truckLateralPhoto1,
    this.truckPlatePhoto,
  });

  VehicleData updateVehicleDataWithReceivedPhotosUrl(VehicleData vehicleData) {
    vehicleData.truckPhotos.truckPlatePhoto = this.truckPlatePhoto;
    vehicleData.truckPhotos.truckLateralPhoto1 = this.truckLateralPhoto1;
    vehicleData.truckPhotos.truckLateralPhoto2 = this.truckLateralPhoto2;
    vehicleData.truckPhotos.truckRearPlatePhoto = this.truckRearPlatePhoto;

    return vehicleData;
  }

  static VehicleDataPhoto fromJson(Map<String, dynamic> json){
    return _$VehicleDataPhotoFromJson(json);
  }
}

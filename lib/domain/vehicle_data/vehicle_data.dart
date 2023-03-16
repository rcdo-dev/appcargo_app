import 'dart:io';

import 'package:app_cargo/domain/truck/truck.dart';
import 'package:app_cargo/domain/truck_photo/truck_photo.dart';
import 'package:app_cargo/domain/truck_photo/truck_photos.dart';
import 'package:app_cargo/domain/truck_trailer/truck_trailer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_data.g.dart';

@JsonSerializable()
class VehicleData {
  String plate;
  String renavam;
  String vin;

  String modelFipeId;
  String makeFipeId;
  String modelYear;

  @JsonKey(fromJson: TrailerType.fromJson, toJson: TrailerType.toJson)
  TrailerType truckLoadType;
  @JsonKey(fromJson: TruckType.fromJson, toJson: TruckType.toJson)
  TruckType truckType;
  @JsonKey(fromJson: TruckAxles.fromJson, toJson: TruckAxles.toJson)
  TruckAxles axles;

  bool hasPanicButton;
  bool hasSiren;
  bool hasDoorBlocker;
  bool hasFifthWheelBlocker;
  bool hasTrailerBlocker;

  bool hasCarTracker;
  String carTrackerName;
  bool hasCarInsurance;
  String carInsuranceName;
  bool hasCarLocator;
  String carLocatorName;

  @JsonKey(fromJson: TrackerType.fromJson, toJson: TrackerType.toJson)
  TrackerType trackerType;

  @JsonKey(fromJson: TruckPhotos.fromJson, toJson: TruckPhotos.toJson)
  TruckPhotos truckPhotos;

  @JsonKey(fromJson: VehicleData.fromJsonTruckTrailers, toJson: VehicleData.toJsonTruckTrailers)
  List<TruckTrailer> trailers;

  VehicleData({
    this.vin,
    this.hasCarTracker,
    this.hasCarLocator,
    this.hasCarInsurance,
    this.hasPanicButton,
    this.hasSiren,
    this.hasDoorBlocker,
    this.hasFifthWheelBlocker,
    this.hasTrailerBlocker,
    this.carTrackerName,
    this.carLocatorName,
    this.carInsuranceName,
    this.plate,
    this.renavam,
    this.modelFipeId,
    this.makeFipeId,
    this.modelYear,
    this.truckType,
    this.truckLoadType,
    this.trackerType,
    this.truckPhotos,
    this.trailers,
    this.axles,
  });

  static Map<String, dynamic> toJson(VehicleData vehicleData) {
    return _$VehicleDataToJson(vehicleData);
  }

  static VehicleData fromJson(Map<String, dynamic> json) {
    return _$VehicleDataFromJson(json);
  }

  static List<Map<String, dynamic>> toJsonTruckTrailers(List<TruckTrailer> trailers){
    List<Map<String, dynamic>> json = new List<Map<String, dynamic>>();

    for(TruckTrailer trailer in trailers){
      json.add(TruckTrailer.toJson(trailer));
    }

    return json;
  }

  static List<TruckTrailer> fromJsonTruckTrailers(List<dynamic> jsonList){
    List<TruckTrailer> trailers = new List<TruckTrailer>();

    for(Map<String, dynamic> jsonItem in jsonList){
      trailers.add(TruckTrailer.fromJson(jsonItem));
    }

    return trailers;
  }
}

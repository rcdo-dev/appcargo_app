import 'dart:io';

import 'package:app_cargo/db/trailer_dao.dart';
import 'package:app_cargo/domain/truck/truck.dart';
import 'package:app_cargo/domain/truck_photo/truck_photo.dart';
import 'package:app_cargo/domain/truck_photo/truck_photos.dart';
import 'package:app_cargo/domain/truck_trailer/truck_trailer.dart';
import 'package:app_cargo/domain/vehicle_data/vehicle_data.dart';
import "package:sqflite/sqflite.dart";

import "database_provider.dart";

final String table = "vehicle_data";

class VehicleDataDAO {
  final DatabaseProvider _databaseProvider;
  final TrailerDAO _trailerDAO;

  VehicleDataDAO(this._databaseProvider, this._trailerDAO);

  // Verify if the hash already exist in the db and them return
  Future<int> insert(VehicleData row) async {
    Database db = await _databaseProvider.database;
    VehicleData vehicleData = await queryAllRows();
    if (vehicleData == null) {
      return await db.insert(
        table,
        toMap(row),
      );
    } else {
      return await update(row);
    }
  }

  // Return all rows
  Future<VehicleData> queryAllRows() async {
    Database db = await _databaseProvider.database;
    List<VehicleData> list = new List<VehicleData>();
    List<Map<String, dynamic>> result = await db.query(table);
    for (Map<String, dynamic> item in result) {
      list.add(await fromMap(item));
    }
    return list.length > 0 ? list[0] : null;
  }

  // Count the amount of rows, just for debug
  Future<int> queryRowCount() async {
    Database db = await _databaseProvider.database;
    return Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $table"));
  }

  // Update the first row, because this is just for cash
  Future<int> update(VehicleData row) async {
    Database db = await _databaseProvider.database;
    return await db.update(table, toMap(row), where: "id = 1");
  }

  // Delete a row
  Future<int> delete() async {
    Database db = await _databaseProvider.database;
    return await db.delete(table, where: "id = 1");
  }

  Map<String, dynamic> toMap(VehicleData vehicleData) {
    _trailerDAO.insertAll(vehicleData.trailers);
    
    return <String, dynamic>{
      "plate": vehicleData.plate,
      "renavam": vehicleData.renavam,
      "vin": vehicleData.vin,

      "modelFipeId": vehicleData.modelFipeId,
      "makeFipeId": vehicleData.makeFipeId,
      "modelYear": vehicleData.modelYear,

      "truckLoadType": TrailerType.toJson(vehicleData.truckLoadType),
      "truckType":TruckType.toJson(vehicleData.truckType),
      "axles": TruckAxles.toJson(vehicleData.axles),

      "hasPanicButton": (vehicleData.hasPanicButton != null) ? (vehicleData.hasPanicButton ? 1 : 0) : 0,
      "hasSiren":(vehicleData.hasSiren != null) ? (vehicleData.hasSiren ? 1 : 0) : 0,
      "hasDoorBlocker":(vehicleData.hasDoorBlocker != null) ? (vehicleData.hasDoorBlocker ? 1 : 0) : 0,
      "hasFifthWheelBlocker":(vehicleData.hasFifthWheelBlocker != null) ? (vehicleData.hasFifthWheelBlocker ? 1 : 0) : 0,
      "hasTrailerBlocker":(vehicleData.hasTrailerBlocker != null) ? (vehicleData.hasTrailerBlocker ? 1 : 0) : 0,

      "hasCarTracker": (vehicleData.hasCarTracker != null) ? (vehicleData.hasCarTracker ? 1 : 0) : 0,
      "carTrackerName": vehicleData.carTrackerName,
      "hasCarInsurance": (vehicleData.hasCarInsurance != null) ? (vehicleData.hasCarInsurance ? 1 : 0) : 0,
      "carInsuranceName": vehicleData.carInsuranceName,
      "hasCarLocator": (vehicleData.hasCarLocator != null) ? (vehicleData.hasCarLocator ? 1 : 0) : 0,
      "carLocatorName": vehicleData.carLocatorName,

      "trackerType": TrackerType.toJson(vehicleData.trackerType),

      if (null != vehicleData.truckPhotos.truckPlatePhoto && null != vehicleData.truckPhotos.truckPlatePhoto.photoUrl)
        'truckPlatePhoto': vehicleData.truckPhotos.truckPlatePhoto.photoUrl,

      if (null != vehicleData.truckPhotos.truckLateralPhoto1 && null != vehicleData.truckPhotos.truckLateralPhoto1.photoUrl)
        'truckLateralPhoto1': vehicleData.truckPhotos.truckLateralPhoto1.photoUrl,

      if (null != vehicleData.truckPhotos.truckLateralPhoto2 && null != vehicleData.truckPhotos.truckLateralPhoto2.photoUrl)
        'truckLateralPhoto2': vehicleData.truckPhotos.truckLateralPhoto2.photoUrl,

      if (null != vehicleData.truckPhotos.truckRearPlatePhoto && null != vehicleData.truckPhotos.truckRearPlatePhoto.photoUrl)
        'truckRearPlatePhoto': vehicleData.truckPhotos.truckRearPlatePhoto.photoUrl,
    };
  }

  Future<VehicleData> fromMap(Map<String, dynamic> map) async {
    TruckPhotos truckPhotos = new TruckPhotos(
      truckPlatePhoto: new TruckPhoto(photoUrl: map["truckPlatePhoto"], type: TruckPhotoType.FRONT_WITH_PLATE),
      truckLateralPhoto1: new TruckPhoto(photoUrl: map["truckLateralPhoto1"], type: TruckPhotoType.SIDE_1),
      truckLateralPhoto2: new TruckPhoto(photoUrl: map["truckLateralPhoto2"],type: TruckPhotoType.SIDE_2),
      truckRearPlatePhoto: new TruckPhoto(photoUrl: map["truckRearPlatePhoto"], type: TruckPhotoType.REAR_WITH_PLATE),
    );
    
    _trailerDAO.queryAllRows().then((trailersData) {
      List<TruckTrailer> trailers = trailersData;
      return new VehicleData(
        plate: map["plate"],
        renavam: map["renavam"],
        vin: map["vin"],

        modelFipeId: map["modelFipeId"],
        makeFipeId: map["makeFipeId"],
        modelYear: map["modelYear"],
        axles: TruckAxles.fromJson(map["axles"]),

        truckLoadType: TrailerType.fromJson(map["truckLoadType"]),
        truckType: TruckType.fromJson(map["truckType"]),

        hasPanicButton: map["hasPanicButton"] == 0 ? false : true,
        hasSiren: map["hasSiren"] == 0 ? false : true,
        hasDoorBlocker: map["hasDoorBlocker"] == 0 ? false : true,
        hasFifthWheelBlocker: map["hasFifthWheelBlocker"] == 0 ? false : true,
        hasTrailerBlocker: map["hasTrailerBlocker"] == 0 ? false : true,

        hasCarTracker: map["hasCarTracker"] == 0 ? false : true,
        carTrackerName: map["carTrackerName"],
        hasCarInsurance: map["hasCarInsurance"] == 0 ? false : true,
        carInsuranceName: map["carInsuranceName"],
        hasCarLocator: map["hasCarLocator"] == 0 ? false : true,
        carLocatorName: map["carLocatorName"],

        trackerType: TrackerType.fromJson(map["trackerType"]),

        truckPhotos: truckPhotos,
        trailers: trailers,
      );
    });
    return null;
  }
}

part of 'settings_vehicle_data.dart';

class SettingsVehicleDataController {
  MaskedTextController plate;
  MaskedTextController renavam;
  MaskedTextController vin;

  FipeModelSummary model;
  FipeBrand brand;
  FipeModelYearSummary modelYear;

  TruckType truckType;
  TrailerType truckLoadType;
  TruckAxles axles;

  bool hasPanicButton;
  bool hasSiren;
  bool hasDoorBlocker;
  bool hasFifthWheelBlocker;
  bool hasTrailerBlocker;

  bool hasCarTracker;
  TextEditingController carTrackerName;
  bool hasCarInsurance;
  TextEditingController carInsuranceName;
  bool hasCarLocator;
  TextEditingController carLocatorName;

  TrackerType trackerType;
  MakeType makeType;

  TruckPhoto frontWithPlatePhoto;
  TruckPhoto side1;
  TruckPhoto side2;
  TruckPhoto rearWithPlate;

  List<TruckTrailer> trailers;

  MaskedTextController trailerPlate1;
  MaskedTextController trailerPlate2;

  SettingsVehicleDataController(VehicleData vehicleData) {
    plate = new MaskedTextController(mask: "AAA0@00", text: vehicleData.plate.replaceAll("-", ""));
    renavam = new MaskedTextController(
        mask: "00000000000", text: vehicleData.renavam);
    vin =
        new MaskedTextController(mask: "@@@@@@@@@@@@@", text: vehicleData.vin);

    model = new FipeModelSummary(id: vehicleData.modelFipeId);
    brand = new FipeBrand(id: vehicleData.makeFipeId);
    modelYear =
        new FipeModelYearSummary(name: vehicleData.modelYear.toString());

    hasCarTracker = vehicleData.hasCarTracker;
    carTrackerName =
        new TextEditingController(text: vehicleData.carTrackerName);
    hasCarInsurance = vehicleData.hasCarInsurance;
    carInsuranceName =
        new TextEditingController(text: vehicleData.carInsuranceName);
    hasCarLocator = vehicleData.hasCarLocator;
    carLocatorName =
        new TextEditingController(text: vehicleData.carLocatorName);

    trailers = vehicleData.trailers;

    hasPanicButton = vehicleData.hasPanicButton;
    hasSiren = vehicleData.hasSiren;
    hasDoorBlocker = vehicleData.hasDoorBlocker;
    hasFifthWheelBlocker = vehicleData.hasFifthWheelBlocker;
    hasTrailerBlocker = vehicleData.hasTrailerBlocker;

    truckType = vehicleData.truckType;
    truckLoadType = vehicleData.truckLoadType;
    trackerType = vehicleData.trackerType;
    axles = vehicleData.axles;

    frontWithPlatePhoto = vehicleData.truckPhotos.truckPlatePhoto;
    side1 = vehicleData.truckPhotos.truckLateralPhoto1;
    side2 = vehicleData.truckPhotos.truckLateralPhoto2;
    rearWithPlate = vehicleData.truckPhotos.truckRearPlatePhoto;

    if (vehicleData.truckType == TruckType.UTILITARIO) {
      makeType = MakeType.car_or_utilitary;
    } else {
      makeType = MakeType.truck;
    }

    trailerPlate1 = MaskedTextController(mask: "AAA0@00", text: trailers[0].plate.replaceAll("-", ""));
    trailerPlate2 = MaskedTextController(mask: "AAA0@00", text: trailers[1].plate.replaceAll("-", ""));
  }

  String manufacturingYear;

  VehicleData getVehicleData() {
    trailers[0].plate = trailerPlate1.text;
    trailers[1].plate = trailerPlate2.text;

    return new VehicleData(
      plate: plate.text,
      vin: vin.text,
      renavam: renavam.text,
      makeFipeId: brand.id,
      modelFipeId: model.id,
      modelYear: modelYear.name,
      hasCarTracker: hasCarTracker,
      carTrackerName: carTrackerName.text,
      hasCarLocator: hasCarLocator,
      carLocatorName: carLocatorName.text,
      hasCarInsurance: hasCarInsurance,
      carInsuranceName: carInsuranceName.text,
      hasPanicButton: hasPanicButton,
      hasSiren: hasSiren,
      hasDoorBlocker: hasDoorBlocker,
      hasFifthWheelBlocker: hasFifthWheelBlocker,
      hasTrailerBlocker: hasTrailerBlocker,
      truckLoadType: truckLoadType,
      truckType: truckType,
      trackerType: trackerType,
      truckPhotos: new TruckPhotos(),
      axles: axles,
      trailers: trailers,
    );
  }
}

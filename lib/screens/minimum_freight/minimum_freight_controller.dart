import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_load_type.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_truck_axles.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_type.dart';
import 'package:app_cargo/services/minimum_freight/minimum_freight_service.dart';

class MinimumFreightController {
  final MinimumFreightService _minimumFreightService =
      DIContainer().get<MinimumFreightService>();

  String validate(double distanceInKilometers, MinimumFreightType type,
      MinimumFreightLoadType loadType, MinimumFreightTruckAxles truckAxles) {
    if (distanceInKilometers == null) {
      return "Preencha a distância corretamente";
    }

    if (type == null || loadType == null || truckAxles == null) {
      return "Preencha os campos correntamente";
    }

    return null;
  }

  double calculateDisplacementCost(
      double distanceInKilometers,
      MinimumFreightType type,
      MinimumFreightLoadType loadType,
      MinimumFreightTruckAxles truckAxles) {
    double displacementCost =
        _minimumFreightService.getDisplacementCost(type, loadType, truckAxles);
    if (displacementCost == null ||
        distanceInKilometers == null ||
        type == null ||
        loadType == null ||
        truckAxles == null) {
      return null;
    }
    return displacementCost * distanceInKilometers;
  }

  double calculateLoadAndUnloadCost(MinimumFreightType type,
      MinimumFreightLoadType loadType, MinimumFreightTruckAxles truckAxles) {
    if (type == null || loadType == null || truckAxles == null) {
      return null;
    }
    return _minimumFreightService.getLoadAndUnloadCost(
        type, loadType, truckAxles);
  }

  double calculateTotal(double displacementCost, double loadAndUnloadCost) {
    return displacementCost + loadAndUnloadCost;
  }
}

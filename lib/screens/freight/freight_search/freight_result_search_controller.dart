part of 'freight_result_search.dart';

class FreightResultSearchController {
  String destiny;
  String radius;
  bool onlyAmountFreight;
  bool freightForwarding;
  bool vehicleWithTracker;
  bool vehicleWithoutTracker;

  FreightResultSearchController({
    this.radius = "Raio",
    this.destiny = "Destino",
    this.freightForwarding = false,
    this.onlyAmountFreight = false,
    this.vehicleWithoutTracker = false,
    this.vehicleWithTracker = false,
  });
}

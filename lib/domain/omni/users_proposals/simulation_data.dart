import 'package:json_annotation/json_annotation.dart';

part 'simulation_data.g.dart';

@JsonSerializable()
class SimulationData {

  String friendlyHash;
  String licensePlate;
  String requestDate;
  String statusText;
  String status;

  static Map<String, dynamic> toJson(SimulationData simulationData) {
    return _$SimulationDataToJson(simulationData);
  }

  static SimulationData fromJson(Map<String, dynamic> json) {
    return _$SimulationDataFromJson(json);
  }
}

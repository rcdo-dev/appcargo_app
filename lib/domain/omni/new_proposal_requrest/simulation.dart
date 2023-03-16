import 'package:json_annotation/json_annotation.dart';

part 'simulation.g.dart';

@JsonSerializable()
class Simulation {

  String itin;
  String birthDate;
  String phone;
  String zipCode;
  String uf;
  String licensePlate;
  double monthlyIncome;

  static Map<String, dynamic> toJson(Simulation simulation) {
    return _$SimulationToJson(simulation);
  }

  static Simulation fromJson(Map<String, dynamic> json) {
    return _$SimulationFromJson(json);
  }

}
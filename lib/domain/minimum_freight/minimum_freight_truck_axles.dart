import 'package:app_cargo/constants/enum.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_load_type_helper.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_truck_axles_helper.dart';

class MinimumFreightTruckAxles implements NamedEnum {
  final String _name;
  final String _jsonName;

  const MinimumFreightTruckAxles._(this._jsonName, this._name);

  @override
  String name() => _name;

  @override
  String uniqueName() => _jsonName;

  static String toJson(MinimumFreightTruckAxles minimumFreightTruckAxles) {
    if (minimumFreightTruckAxles != null)
      return minimumFreightTruckAxles._jsonName;
    else
      return null;
  }

  static MinimumFreightTruckAxles fromJson(String val) {
    if (val != null)
      return MinimumFreightTruckAxlesHelper().from(val);
    else
      return null;
  }

  static const DOIS_EIXOS = MinimumFreightTruckAxles._("2", "2");
  static const TRES_EIXOS = MinimumFreightTruckAxles._("3", "3");
  static const QUATRO_EIXOS = MinimumFreightTruckAxles._("4", "4");
  static const CINCO_EIXOS = MinimumFreightTruckAxles._("5", "5");
  static const SEIS_EIXOS = MinimumFreightTruckAxles._("6", "6");
  static const SETE_EIXOS = MinimumFreightTruckAxles._("7", "7");
  static const NOVE_EIXOS = MinimumFreightTruckAxles._("9", "9");
}
import 'package:app_cargo/constants/enum.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_truck_axles_helper.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_type_helper.dart';

class MinimumFreightType implements NamedEnum {
  final String _name;
  final String _jsonName;

  const MinimumFreightType._(this._jsonName, this._name);

  @override
  String name() => _name;

  @override
  String uniqueName() => _jsonName;

  static String toJson(MinimumFreightType minimumFreightType) {
    if (minimumFreightType != null)
      return minimumFreightType._jsonName;
    else
      return null;
  }

  static MinimumFreightType fromJson(String val) {
    if (val != null)
      return MinimumFreightTypeHelper().from(val);
    else
      return null;
  }

  static const LOTATION = MinimumFreightType._("LOTATION", "Lotação");
  static const LOAD_VEHICLE = MinimumFreightType._("LOAD_VEHICLE", "Apenas automotor");
}
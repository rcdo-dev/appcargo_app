import 'package:app_cargo/constants/enum.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_load_type_helper.dart';

class MinimumFreightLoadType implements NamedEnum {
  final String _name;
  final String _jsonName;

  const MinimumFreightLoadType._(this._jsonName, this._name);

  @override
  String name() => _name;

  @override
  String uniqueName() => _jsonName;

  static String toJson(MinimumFreightLoadType minimumFreightLoadType) {
    if (minimumFreightLoadType != null)
      return minimumFreightLoadType._jsonName;
    else
      return null;
  }

  static MinimumFreightLoadType fromJson(String val) {
    if (val != null)
      return MinimumFreightLoadTypeHelper().from(val);
    else
      return null;
  }

  static const GRANEL_SOLIDO = MinimumFreightLoadType._("GRANEL_SOLIDO", "Granel sólido");
  static const GRANEL_LIQUIDO = MinimumFreightLoadType._("GRANEL_SOLIDO", "Granel líquido");
  static const FRIGORIFICADA = MinimumFreightLoadType._("FRIGORIFICADA", "Frigorificada");
  static const CONTEINERIZADA = MinimumFreightLoadType._("CONTEINERIZADA", "Conteinerizada");
  static const CARGA_GERAL = MinimumFreightLoadType._("CARGA_GERAL", "Carga geral");
  static const NEOGRANEL = MinimumFreightLoadType._("NEOGRANEL", "Neogranel");
  static const PERIGOSA_GRANEL_SOLIDO = MinimumFreightLoadType._("PERIGOSA_GRANEL_SOLIDO", "Perigosa (granel sólido)");
  static const PERIGOSA_GRANEL_LIQUIDO = MinimumFreightLoadType._("PERIGOSA_GRANEL_LIQUIDO", "Perigosa (granel líquido)");
  static const PERIGOSA_FRIGORIFICADA = MinimumFreightLoadType._("PERIGOSA_FRIGORIFICADA", "Perigosa (frigorificada)");
  static const PERIGOSA_CONTEINERIZADA = MinimumFreightLoadType._("PERIGOSA_CONTEINERIZADA", "Perigosa (conteinerizada)");
  static const PERIGOSA_CARGA_GERAL = MinimumFreightLoadType._("PERIGOSA_CARGA_GERAL", "Perigosa (carga geral)");
  static const CARGA_GRANEL_PRESSURIZADA = MinimumFreightLoadType._("CARGA_GRANEL_PRESSURIZADA", "Carga Granel Pressurizada");
}
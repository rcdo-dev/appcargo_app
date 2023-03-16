import 'package:app_cargo/constants/enum.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_load_type.dart';

class MinimumFreightLoadTypeHelper extends EnumHelper<MinimumFreightLoadType> {
  @override
  List<MinimumFreightLoadType> values() => [
    MinimumFreightLoadType.GRANEL_SOLIDO,
    MinimumFreightLoadType.GRANEL_LIQUIDO,
    MinimumFreightLoadType.FRIGORIFICADA,
    MinimumFreightLoadType.CONTEINERIZADA,
    MinimumFreightLoadType.CARGA_GERAL,
    MinimumFreightLoadType.NEOGRANEL,
    MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO,
    MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO,
    MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA,
    MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA,
    MinimumFreightLoadType.PERIGOSA_CARGA_GERAL,
    MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA,
  ];
}
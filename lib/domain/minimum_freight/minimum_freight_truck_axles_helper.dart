import 'package:app_cargo/constants/enum.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_truck_axles.dart';

class MinimumFreightTruckAxlesHelper extends EnumHelper<MinimumFreightTruckAxles> {
  @override
  List<MinimumFreightTruckAxles> values() => [
    MinimumFreightTruckAxles.DOIS_EIXOS,
    MinimumFreightTruckAxles.TRES_EIXOS,
    MinimumFreightTruckAxles.QUATRO_EIXOS,
    MinimumFreightTruckAxles.CINCO_EIXOS,
    MinimumFreightTruckAxles.SEIS_EIXOS,
    MinimumFreightTruckAxles.SETE_EIXOS,
    MinimumFreightTruckAxles.NOVE_EIXOS
  ];
}
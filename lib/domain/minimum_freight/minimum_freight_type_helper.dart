import 'package:app_cargo/constants/enum.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_type.dart';

class MinimumFreightTypeHelper extends EnumHelper<MinimumFreightType> {
  @override
  List<MinimumFreightType> values() => [
    MinimumFreightType.LOTATION,
    MinimumFreightType.LOAD_VEHICLE,
  ];
}
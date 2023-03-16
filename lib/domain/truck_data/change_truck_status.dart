import 'package:app_cargo/constants/enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_truck_status.g.dart';

@JsonSerializable()
class ChangeTruckStatus {
  @JsonKey(toJson: TruckStatus.toJson, fromJson: TruckStatus.fromJson)
  TruckStatus status;
  @JsonKey(
      toJson: ChangeTruckStatusData.toJson,
      fromJson: ChangeTruckStatusData.fromJson)
  ChangeTruckStatusData data;

  ChangeTruckStatus({this.status, this.data});

  static Map<String, dynamic> toJson(
      ChangeTruckStatus truckStatusUpdateAvailableData) {
    return _$ChangeTruckStatusToJson(truckStatusUpdateAvailableData);
  }

  static ChangeTruckStatus fromJson(Map<String, dynamic> json) {
    return _$ChangeTruckStatusFromJson(json);
  }
}

@JsonSerializable()
class ChangeTruckStatusData {
  String cityHash;
  int howLong;
  bool notifyNewRequests;

  ChangeTruckStatusData({
    this.notifyNewRequests,
    this.howLong = -1,
    this.cityHash,
  });

  static Map<String, dynamic> toJson(ChangeTruckStatusData truckData) {
    return _$ChangeTruckStatusDataToJson(truckData);
  }

  static ChangeTruckStatusData fromJson(Map<String, dynamic> json) {
    return _$ChangeTruckStatusDataFromJson(json);
  }
}

class TruckStatus implements NamedEnum {
  final String _name;
  final String _jsonName;

  const TruckStatus._(this._name, this._jsonName);

  @override
  String name() => _name;

  @override
  String uniqueName() => _jsonName;

  static String toJson(TruckStatus type) => type.uniqueName();

  static TruckStatus fromJson(String val) => TruckStatusHelper().from(val);

  static const AVAILABLE = TruckStatus._("Sem carga", "AVAILABLE");
  static const LOADED = TruckStatus._("Com carga", "LOADED");
  static const UNLOADING = TruckStatus._("Descarregando", "UNLOADING");
}

class TruckStatusHelper extends EnumHelper<TruckStatus> {
  @override
  List<TruckStatus> values() => [
        TruckStatus.AVAILABLE,
        TruckStatus.LOADED,
        TruckStatus.UNLOADING,
      ];
}

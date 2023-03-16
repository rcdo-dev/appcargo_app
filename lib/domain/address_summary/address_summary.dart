import 'package:app_cargo/domain/lat_lng/lat_lng.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_summary.g.dart';

@JsonSerializable()
class AddressSummary {
  String cityHash;
  String stateHash;
  String cityName;
  String stateAcronym;
  @JsonKey(toJson: LatLng.toJson, fromJson: LatLng.fromJson)
  LatLng position;
  String formatted;

  AddressSummary({
    this.cityHash,
    this.cityName,
    this.stateAcronym,
    this.stateHash,
    this.position,
    this.formatted
  });

  static Map<String, dynamic> toJson(AddressSummary addressSummary) {
    return _$AddressSummaryToJson(addressSummary);
  }

  static AddressSummary fromJson(Map<String, dynamic> json) {
    return _$AddressSummaryFromJson(json);
  }
}

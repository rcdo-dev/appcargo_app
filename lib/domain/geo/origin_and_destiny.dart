import 'package:app_cargo/domain/geo/lat_lng.dart';
import 'package:json_annotation/json_annotation.dart';

part 'origin_and_destiny.g.dart';

@JsonSerializable()
class OriginAndDestiny {
  @JsonKey(toJson: LatLng.toJson)
  LatLng origin;
  @JsonKey(toJson: LatLng.toJson)
  LatLng destiny;

  static Map<String, dynamic> toJson(OriginAndDestiny originAndDestiny) {
    return _$OriginAndDestinyToJson(originAndDestiny);
  }

  static OriginAndDestiny fromJson(Map<String, dynamic> json) {
    return _$OriginAndDestinyFromJson(json);
  }
}
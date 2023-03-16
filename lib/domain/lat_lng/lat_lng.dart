import 'package:app_cargo/constants/converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lat_lng.g.dart';

/// This class implements the attributes required to receive latitude and longitude data
@JsonSerializable()
class LatLng {
  /// Latitude
  @JsonKey(toJson: double.parse, fromJson: Converters.from)
  String latitude;

  /// _$LatLngFromJson(json) Longitude
  @JsonKey(toJson: double.parse, fromJson: Converters.from)
  String longitude;

  LatLng({this.longitude, this.latitude});

  static Map<String, dynamic> toJson(LatLng latLng) {
    if(latLng != null)
      return _$LatLngToJson(latLng);
    else
      return null;
  }

  static LatLng fromJson(Map<String, dynamic> json) {
    if(json != null)
      return _$LatLngFromJson(json);
    else
      return null;
  }
}


import 'package:json_annotation/json_annotation.dart';

part 'lat_lng.g.dart';

@JsonSerializable()
class LatLng {
  double latitude;
  double longitude;

  LatLng({this.latitude = 0, this.longitude = 0});

  static Map<String, dynamic> toJson(LatLng latLng) {
    return _$LatLngToJson(latLng);
  }

  static LatLng fromJson(Map<String, dynamic> json) {
    return _$LatLngFromJson(json);
  }
}

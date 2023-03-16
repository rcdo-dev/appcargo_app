import 'package:app_cargo/domain/lat_lng/lat_lng.dart';
import 'package:json_annotation/json_annotation.dart';

part 'freight_search_query.g.dart';

@JsonSerializable()
class FreightSearchQuery {
  String originCityHash;
  int originRadiusInKM;
  String destinationCityHash;
  int destinationRadiusInKM;
  bool antt;
  @JsonKey(toJson: LatLng.toJson, fromJson: LatLng.fromJson)
  LatLng position;

  FreightSearchQuery({
    this.position,
    this.antt,
    this.destinationCityHash,
    this.destinationRadiusInKM,
    this.originCityHash,
    this.originRadiusInKM,
  });

  static Map<String, dynamic> toJson(FreightSearchQuery freightSearch) {
    return _$FreightSearchQueryToJson(freightSearch);
  }

  static FreightSearchQuery fromJson(Map<String, dynamic> json) {
    return _$FreightSearchQueryFromJson(json);
  }
}

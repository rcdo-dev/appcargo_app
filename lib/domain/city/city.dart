import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable()
class City {
  String hash;
  String name;
  double latitude;
  double longitude;

  City({this.hash, this.name, this.latitude, this.longitude});

  static Map<String, dynamic> toJson(City city) {
    if (city != null)
      return _$CityToJson(city);
    else
      return null;
  }

  static City fromJson(Map<String, dynamic> json) {
    if (json != null)
      return _$CityFromJson(json);
    else
      return new City();
  }

  @override
  bool operator ==(other) {
    if (other is City) {
      if (this.hash != null && other.hash != null) {
        if (this.hash == other.hash) {
          return true;
        }
      }

      if (this.name != null && other.name != null) {
        if (this.name == other.name) {
          return true;
        }
      }
    }

    return false;
  }
}

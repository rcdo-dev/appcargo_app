import 'package:app_cargo/domain/city/city.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable()
class AddressState {
  String hash;
  String name;
  String acronym;
  @JsonKey(toJson: AddressState.citiesToJson)
  List<City> cities;

  AddressState({
    this.name,
    this.hash,
    this.acronym,
    this.cities,
  });

  static Map<String, dynamic> toJson(AddressState state) {
    return _$AddressStateToJson(state);
  }

  static AddressState fromJson(Map<String, dynamic> json) {
    if(json != null)
      return _$AddressStateFromJson(json);
    else
      return new AddressState();
  }

  static List<Map<String, dynamic>> citiesToJson(List<City> cities) {
    List<Map<String, dynamic>> citiesReturn = new List<Map<String, dynamic>>();
    if (cities != null) {
      for (City city in cities) {
        citiesReturn.add(City.toJson(city));
      }
    }
    return citiesReturn;
  }
}

import 'package:json_annotation/json_annotation.dart';

part 'omni_civil_states.g.dart';

@JsonSerializable()
class OmniCivilStates {

  @JsonKey(name: "id")
  int civilStateId;
  String description;

  static List<String> mapToBuildCivilStateDropdown(List<OmniCivilStates> list) {
    List<String> civilStates = List<String>();
    civilStates.insert(0, "Selecione um estado civil");
    for(OmniCivilStates classes in list){
      civilStates.add(classes.description);
    }
    return civilStates;
  }

  static Map<String, dynamic> toJson(OmniCivilStates civilStates) {
    return _$OmniCivilStatesToJson(civilStates);
  }

  static OmniCivilStates fromJson(Map<String, dynamic> json) {
    return _$OmniCivilStatesFromJson(json);
  }

}
import 'package:json_annotation/json_annotation.dart';

part 'omni_profession.g.dart';

@JsonSerializable()
class OmniProfession {

  @JsonKey(name: "id")
  int professionId;

  @JsonKey(name: "profissionalGroup")
  String professionalGroup;
  String description;

  static List<String> mapToBuildProfessionsClassesDropdown(List<OmniProfession> professionList) {
    List<String> _professionList = List<String>();
    _professionList.insert(0, "Selecione uma profissão");
    for(OmniProfession professions in professionList){
      _professionList.add(professions.description);
    }
    return _professionList;
  }

  static Map<String, dynamic> toJson(OmniProfession profession) {
    return _$OmniProfessionToJson(profession);
  }

  static OmniProfession fromJson(Map<String, dynamic> json) {
    return _$OmniProfessionFromJson(json);
  }

}
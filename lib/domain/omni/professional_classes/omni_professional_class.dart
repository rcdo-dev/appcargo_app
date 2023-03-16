import 'package:json_annotation/json_annotation.dart';

part 'omni_professional_class.g.dart';

@JsonSerializable()
class OmniProfessionalClass {

  @JsonKey(name: "id")
  int professionalClassId;
  String description;

  static List<String> mapToBuildProfessionsClassesDropdown(List<OmniProfessionalClass> list) {
    List<String> descriptions = List<String>();
    descriptions.insert(0, "Selecione uma classe profissional");
    for(OmniProfessionalClass classes in list){
      descriptions.add(classes.description);
    }
    return descriptions;
  }

  static Map<String, dynamic> toJson(OmniProfessionalClass professionalClass) {
    return _$OmniProfessionalClassToJson(professionalClass);
  }

  static OmniProfessionalClass fromJson(Map<String, dynamic> json) {
    return _$OmniProfessionalClassFromJson(json);
  }

}
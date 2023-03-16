// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'omni_profession.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OmniProfession _$OmniProfessionFromJson(Map<String, dynamic> json) {
  return OmniProfession()
    ..professionId = json['id'] as int
    ..professionalGroup = json['profissionalGroup'] as String
    ..description = json['description'] as String;
}

Map<String, dynamic> _$OmniProfessionToJson(OmniProfession instance) =>
    <String, dynamic>{
      'id': instance.professionId,
      'profissionalGroup': instance.professionalGroup,
      'description': instance.description,
    };

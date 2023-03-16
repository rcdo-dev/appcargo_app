// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'omni_professional_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OmniProfessionalClass _$OmniProfessionalClassFromJson(
    Map<String, dynamic> json) {
  return OmniProfessionalClass()
    ..professionalClassId = json['id'] as int
    ..description = json['description'] as String;
}

Map<String, dynamic> _$OmniProfessionalClassToJson(
        OmniProfessionalClass instance) =>
    <String, dynamic>{
      'id': instance.professionalClassId,
      'description': instance.description,
    };

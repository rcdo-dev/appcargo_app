// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'omni_civil_states.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OmniCivilStates _$OmniCivilStatesFromJson(Map<String, dynamic> json) {
  return OmniCivilStates()
    ..civilStateId = json['id'] as int
    ..description = json['description'] as String;
}

Map<String, dynamic> _$OmniCivilStatesToJson(OmniCivilStates instance) =>
    <String, dynamic>{
      'id': instance.civilStateId,
      'description': instance.description,
    };

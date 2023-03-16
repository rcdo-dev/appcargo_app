// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return Chat(
    members: (json['members'] as List)?.map((e) => e as String)?.toList(),
    hidden: json['hidden'] as bool,
  );
}

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'members': instance.members,
      'hidden': instance.hidden,
    };

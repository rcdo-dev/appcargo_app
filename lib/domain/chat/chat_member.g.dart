// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMember _$ChatMemberFromJson(Map<String, dynamic> json) {
  return ChatMember()
    ..hash = json['hash'] as String
    ..imageUrl = json['imageUrl'] as String
    ..name = json['name'] as String
    ..phone = json['phone'] as String;
}

Map<String, dynamic> _$ChatMemberToJson(ChatMember instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'phone': instance.phone,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    hashSender: json['hashSender'] as String,
    content: json['content'] as Map<String, dynamic>,
    showToDriver: json['showToDriver'] as bool,
    showToPartnerOrFreightCo: json['showToPartnerOrFreightCo'] as bool,
  )..documentID = json['documentID'] as String;
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'documentID': instance.documentID,
      'hashSender': instance.hashSender,
      'content': instance.content,
      'showToDriver': instance.showToDriver,
      'showToPartnerOrFreightCo': instance.showToPartnerOrFreightCo,
    };

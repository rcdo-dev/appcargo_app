// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplaintReply _$ComplaintReplyFromJson(Map<String, dynamic> json) {
  return ComplaintReply(
    message: json['message'] as String,
    isFreightCo: json['isFreightCo'] as bool,
    photo: json['photo'] as String,
  );
}

Map<String, dynamic> _$ComplaintReplyToJson(ComplaintReply instance) =>
    <String, dynamic>{
      'isFreightCo': instance.isFreightCo,
      'message': instance.message,
      'photo': instance.photo,
    };

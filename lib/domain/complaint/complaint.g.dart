// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Complaint _$ComplaintFromJson(Map<String, dynamic> json) {
  return Complaint(
    message: json['message'] as String,
    hash: json['hash'] as String,
    code: json['code'] as String,
    photo: json['photo'] as String,
    replies: (json['replies'] as List)
        ?.map((e) => e == null
            ? null
            : ComplaintReply.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    subject: json['subject'] as String,
  );
}

Map<String, dynamic> _$ComplaintToJson(Complaint instance) => <String, dynamic>{
      'hash': instance.hash,
      'code': instance.code,
      'subject': instance.subject,
      'message': instance.message,
      'photo': instance.photo,
      'replies': instance.replies,
    };

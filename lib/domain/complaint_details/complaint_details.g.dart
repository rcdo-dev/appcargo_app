// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplaintDetails _$ComplaintDetailsFromJson(Map<String, dynamic> json) {
  return ComplaintDetails(
    subject: json['subject'] as String,
    code: json['code'] as String,
    hash: json['hash'] as String,
    photo: json['photo'] as String,
    message: json['message'] as String,
    replies: (json['replies'] as List)
        ?.map((e) => e == null
            ? null
            : ComplaintReply.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ComplaintDetailsToJson(ComplaintDetails instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'code': instance.code,
      'subject': instance.subject,
      'message': instance.message,
      'photo': instance.photo,
      'replies': instance.replies,
    };

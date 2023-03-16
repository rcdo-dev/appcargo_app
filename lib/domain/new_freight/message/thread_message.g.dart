// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThreadMessage _$ThreadMessageFromJson(Map<String, dynamic> json) {
  return ThreadMessage(
    hash: json['hash'] as String,
    content: json['content'] as String,
    sentByDriver: json['sentByDriver'] as bool,
    sentAt: json['sentAt'] as String,
    media: json['media'] as String,
    mediaContentType: json['mediaContentType'] as String,
  );
}

Map<String, dynamic> _$ThreadMessageToJson(ThreadMessage instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'content': instance.content,
      'sentByDriver': instance.sentByDriver,
      'sentAt': instance.sentAt,
      'media': instance.media != null ? Media.toJson(instance.media) : null,
      'mediaContentType': instance.mediaContentType,
    };

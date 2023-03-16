// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_threads.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverThreads _$DriverThreadsFromJson(Map<String, dynamic> json) {
  return DriverThreads(
    hash: json['hash'] as String,
    reference: json['reference'] as String,
    type: json['type'] as String,
    lastMessageSentAt: json['lastMessageSentAt'] as String,
    numUnreadMessages: json['numUnreadMessages'] as int,
    deletedByDriver: json['deletedByDriver'] as bool,
    threadFreightSummary: json['threadFreightSummary'] as ThreadFreightSummary,
  );
}

Map<String, dynamic> _$DriverThreadsToJson(DriverThreads instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'reference': instance.reference,
      'type': instance.type,
      'lastMessageSentAt': instance.lastMessageSentAt,
      'numUnreadMessages': instance.numUnreadMessages,
      'deletedByDriver': instance.deletedByDriver,
      'threadFreightSummary': instance.threadFreightSummary,
    };

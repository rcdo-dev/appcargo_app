// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) {
  return Report()
    ..documentID = json['documentID'] as String
    ..message = json['message'] == null
        ? null
        : Message.fromJson(json['message'] as Map<String, dynamic>)
    ..senderHash = json['senderHash'] as String
    ..senderName = json['senderName'] as String
    ..senderPhone = json['senderPhone'] as String
    ..receiverHash = json['receiverHash'] as String
    ..receiverName = json['receiverName'] as String
    ..receiverPhone = json['receiverPhone'] as String;
}

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'documentID': instance.documentID,
      'message': Message.toJson(instance.message),
      'senderHash': instance.senderHash,
      'senderName': instance.senderName,
      'senderPhone': instance.senderPhone,
      'receiverHash': instance.receiverHash,
      'receiverName': instance.receiverName,
      'receiverPhone': instance.receiverPhone,
    };

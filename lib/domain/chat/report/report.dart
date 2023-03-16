import 'package:app_cargo/domain/chat/message/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

@JsonSerializable()
class Report {
  String documentID;

  @JsonKey(toJson: Message.toJson)
  Message message;

  String senderHash;
  String senderName;
  String senderPhone;

  String receiverHash;
  String receiverName;
  String receiverPhone;

  @JsonKey(ignore: true)
  Timestamp timestamp;

  static Map<String, dynamic> toJson(Report report) {
    return _$ReportToJson(report);
  }

  static Report fromJson(Map<String, dynamic> json) {
    return _$ReportFromJson(json);
  }

  static Map<String, dynamic> serializeToSave(Map<String, dynamic> map, Report report) {
    map.remove("documentID");
    map["message"].remove("documentID");
    map["message"].remove("showToDriver");
    map["message"].remove("showToPartnerOrFreightCo");

    map["message"]["timestamp"] = report.message.timestamp;

    return map;
  }
}
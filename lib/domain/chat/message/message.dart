import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  String documentID;
  String hashSender;
  Map content;
  bool showToDriver;
  bool showToPartnerOrFreightCo;

  @JsonKey(ignore: true)
  Timestamp timestamp;

  Message({
    this.hashSender,
    this.content,
    this.timestamp,
    this.showToDriver,
    this.showToPartnerOrFreightCo
  });

  static Map<String, dynamic> toJson(Message message) {
    return _$MessageToJson(message);
  }

  static Message fromJson(Map<String, dynamic> json) {
    return _$MessageFromJson(json);
  }

  static Map<String, dynamic> serializeToSend(Map<String, dynamic> map) {
    map.remove("documentID");

    return map;
  }
}

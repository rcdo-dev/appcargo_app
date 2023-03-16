import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  List<String> members;
  bool hidden;

  @JsonKey(ignore: true)
  Timestamp lastSent;

  Chat({this.members, this.hidden, this.lastSent});

  static Map<String, dynamic> toJson(Chat chat) {
    return _$ChatToJson(chat);
  }

  static Chat fromJson(Map<String, dynamic> json) {
    return _$ChatFromJson(json);
  }
}
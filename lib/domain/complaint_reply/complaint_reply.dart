import 'package:json_annotation/json_annotation.dart';

part 'complaint_reply.g.dart';

@JsonSerializable()
class ComplaintReply {
  bool isFreightCo;
  String message;
  String photo;

  ComplaintReply({
    this.message,
    this.isFreightCo,
    this.photo,
  });

  static Map<String, dynamic> toJson(ComplaintReply complaintReply) {
    return _$ComplaintReplyToJson(complaintReply);
  }

  static ComplaintReply fromJson(Map<String, dynamic> json) {
    return _$ComplaintReplyFromJson(json);
  }
}

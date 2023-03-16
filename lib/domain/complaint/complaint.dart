import 'package:app_cargo/domain/complaint_reply/complaint_reply.dart';
import 'package:json_annotation/json_annotation.dart';

part 'complaint.g.dart';

@JsonSerializable()
class Complaint {
  String hash;
  String code;
  String subject;
  String message;
  String photo;
  List<ComplaintReply> replies;

  Complaint({
    this.message,
    this.hash,
    this.code,
    this.photo,
    this.replies,
    this.subject,
  });

  String toJson(Complaint complaint) {
    return _$ComplaintToJson(complaint).toString();
  }
}

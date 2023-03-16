import 'package:app_cargo/domain/complaint_reply/complaint_reply.dart';
import 'package:json_annotation/json_annotation.dart';

part 'complaint_details.g.dart';

@JsonSerializable()
class ComplaintDetails {
  String hash;
  String code;
  String subject;
  String message;
  String photo;
  List<ComplaintReply> replies;

  ComplaintDetails({
    this.subject,
    this.code,
    this.hash,
    this.photo,
    this.message,
    this.replies,
  });

  static Map<String, dynamic> toJson(ComplaintDetails complaintDetails) {
    return _$ComplaintDetailsToJson(complaintDetails);
  }

  static ComplaintDetails fromJson(Map<String, dynamic> json) {
    return _$ComplaintDetailsFromJson(json);
  }
}

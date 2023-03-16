import 'package:json_annotation/json_annotation.dart';

part 'complaint_summary.g.dart';

@JsonSerializable()
class ComplaintSummary {
  String hash;
  String code;
  String subject;

  ComplaintSummary({this.hash, this.code, this.subject});

  static Map<String, dynamic> toJson(ComplaintSummary complaintSummary) {
    return _$ComplaintSummaryToJson(complaintSummary);
  }

  static ComplaintSummary fromJson(Map<String, dynamic> json) {
    return _$ComplaintSummaryFromJson(json);
  }
}

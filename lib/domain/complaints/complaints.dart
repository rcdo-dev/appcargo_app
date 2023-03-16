import 'package:app_cargo/domain/complaint_details/complaint_details.dart';
import 'package:app_cargo/domain/complaint_summary/complaint_summary.dart';
import 'package:json_annotation/json_annotation.dart';

part 'complaints.g.dart';

@JsonSerializable()
class Complaints {
  List<ComplaintDetails> open;
  List<ComplaintSummary> closed;

  Complaints({this.closed, this.open});

  static Map<String, dynamic> toJson(Complaints complaints) {
    return _$ComplaintsToJson(complaints);
  }

  static Complaints fromJson(Map<String, dynamic> json) {
    return _$ComplaintsFromJson(json);
  }
}

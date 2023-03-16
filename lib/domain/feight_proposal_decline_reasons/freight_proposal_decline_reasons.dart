import 'package:json_annotation/json_annotation.dart';

part 'freight_proposal_decline_reasons.g.dart';

@JsonSerializable()
class FreightProposalDeclineReason {
  String hash;
  String description;

  FreightProposalDeclineReason({this.hash, this.description});

  static Map<String, dynamic> toJson(FreightProposalDeclineReason declineReasons) {
    return _$FreightProposalDeclineReasonToJson(declineReasons);
  }

  static FreightProposalDeclineReason fromJson(Map<String, dynamic> json) {
    return _$FreightProposalDeclineReasonFromJson(json);
  }
}

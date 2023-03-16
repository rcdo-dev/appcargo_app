import 'package:app_cargo/domain/address_summary/address_summary.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thread_freight_summary.g.dart';

@JsonSerializable()
class ThreadFreightSummary {
  String hash;
  @JsonKey(toJson: AddressSummary.toJson, fromJson: AddressSummary.fromJson)
  AddressSummary from;
  @JsonKey(toJson: AddressSummary.toJson, fromJson: AddressSummary.fromJson)
  AddressSummary to;
  int distanceInMeters;
  String creationDate;
  List<dynamic> errors;

  ThreadFreightSummary(
      {this.hash,
      this.from,
      this.to,
      this.distanceInMeters,
      this.creationDate,
      this.errors});

  static Map<String, dynamic> toJson(ThreadFreightSummary freightSummary) {
    if (freightSummary != null)
      return _$ThreadFreightSummaryToJson(freightSummary);
    else
      return null;
  }

  static ThreadFreightSummary fromJson(Map<String, dynamic> json) {
    if (json != null)
      return _$ThreadFreightSummaryFromJson(json);
    else
      return null;
  }
}

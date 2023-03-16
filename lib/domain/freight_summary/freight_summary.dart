import 'package:app_cargo/domain/address_summary/address_summary.dart';
import 'package:json_annotation/json_annotation.dart';

part 'freight_summary.g.dart';

@JsonSerializable()
class FreightSummary {
  String hash;
  String photoUrl;
  String code;
  @JsonKey(toJson: AddressSummary.toJson, fromJson: AddressSummary.fromJson)
  AddressSummary from;
  @JsonKey(toJson: AddressSummary.toJson, fromJson: AddressSummary.fromJson)
  AddressSummary to;
  String distanceInMeters;
  String freightCoContact;

  FreightSummary(
      {this.code,
      this.photoUrl,
      this.distanceInMeters,
      this.freightCoContact,
      this.from,
      this.hash,
      this.to});

  static Map<String, dynamic> toJson(FreightSummary freightSummary) {
    if (freightSummary != null)
      return _$FreightSummaryToJson(freightSummary);
    else
      return null;
  }

  static FreightSummary fromJson(Map<String, dynamic> json) {
    if (json != null)
      return _$FreightSummaryFromJson(json);
    else
      return null;
  }
}

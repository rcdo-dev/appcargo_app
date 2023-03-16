import 'package:app_cargo/domain/address_summary/address_summary.dart';
import 'package:json_annotation/json_annotation.dart';

part 'freight_company_summary.g.dart';

@JsonSerializable()
class FreightCompanySummary {
  String hash;
  String accessCredentialHash;
  String name;
  String photo;
  int rating;
  int positionInRanking;
  String contact;
  @JsonKey(toJson: AddressSummary.toJson, fromJson: AddressSummary.fromJson)
  AddressSummary address;

  FreightCompanySummary({
    this.rating,
    this.contact,
    this.address,
    this.hash,
    this.name,
    this.photo,
    this.positionInRanking,
    this.accessCredentialHash,
  });

  static Map<String, dynamic> toJson(
      FreightCompanySummary freightCompanySummary) {
    return _$FreightCompanySummaryToJson(freightCompanySummary);
  }

  static FreightCompanySummary fromJson(Map<String, dynamic> json) {
    return _$FreightCompanySummaryFromJson(json);
  }
}

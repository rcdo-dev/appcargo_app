import 'package:app_cargo/domain/address/address.dart';
import 'package:app_cargo/domain/freight_company_feedback/freight_company_feedback.dart';
import 'package:json_annotation/json_annotation.dart';

part 'freight_company_detail.g.dart';

@JsonSerializable()
class FreightCompanyDetail {
  String hash;
  String accessCredentialHash;
  String name;
  int rating;
  String contact;
  int rankingPosition;
  Address address;
  List<FreightCompanyFeedback> highlightedFeedback;
  String photo;

  FreightCompanyDetail({
    this.address,
    this.contact,
    this.rating,
    this.highlightedFeedback,
    this.rankingPosition,
    this.accessCredentialHash,
    this.name,
    this.hash,
    this.photo,
  });

  static Map<String, dynamic> toJson(
      FreightCompanyDetail freightCompanyDetail) {
    return _$FreightCompanyDetailToJson(freightCompanyDetail);
  }

  static FreightCompanyDetail fromJson(Map<String, dynamic> json) {
    return _$FreightCompanyDetailFromJson(json);
  }
}

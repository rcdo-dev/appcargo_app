import 'package:json_annotation/json_annotation.dart';

part 'referral.g.dart';

@JsonSerializable()
class Referral{
  String referent;

  Referral({this.referent});

  static Map<String, dynamic> toJson(Referral referent){
    return _$ReferralToJson(referent);
  }

  static Referral fromJson(Map<String, dynamic> json){
    return _$ReferralFromJson(json);
  }
}
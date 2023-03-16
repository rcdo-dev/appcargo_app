import 'package:app_cargo/domain/referral/referral.dart';
import 'package:json_annotation/json_annotation.dart';

part 'referrals.g.dart';

@JsonSerializable()
class Referrals {
  @JsonKey(toJson: referralsToJson)
  List<Referral> referrals;

  Referrals({this.referrals});

  static Map<String, dynamic> toJson(Referrals referrals) {
    return _$ReferralsToJson(referrals);
  }

  static Referrals fromJson(Map<String, dynamic> json) {
    return _$ReferralsFromJson(json);
  }

  static List<Map<String, dynamic>> referralsToJson(List<Referral> referrals) {
    List<Map<String, dynamic>> listJson = new List<Map<String, dynamic>>();

    for (Referral referral in referrals) {
      listJson.add(Referral.toJson(referral));
    }

    return listJson;
  }
}

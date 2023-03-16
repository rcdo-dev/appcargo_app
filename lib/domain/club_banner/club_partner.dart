import 'package:json_annotation/json_annotation.dart';

part 'club_partner.g.dart';

@JsonSerializable()
class ClubPartner {
  String hash;
  String name;
  String photo;
  String logoToShowOnAppBannersPage;
  int bannerQuantity;
  String description;

  ClubPartner({
    this.hash,
    this.name,
    this.photo,
    this.logoToShowOnAppBannersPage,
    this.bannerQuantity,
    this.description,
  });

  static Map<String, dynamic> toJson(ClubPartner bp) =>
      null != bp ? _$BannerPartnerToJson(bp) : null;

  static ClubPartner fromJson(Map<String, dynamic> json) =>
      null != json ? _$BannerPartnerFromJson(json) : null;
}

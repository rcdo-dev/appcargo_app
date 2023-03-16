import 'package:app_cargo/domain/club_banner/club_partner.dart';
import 'package:app_cargo/domain/club_banner/club_banner.dart';
import 'package:json_annotation/json_annotation.dart';

part 'partner_banners.g.dart';

@JsonSerializable()
class PartnerBanners {
  ClubPartner partner;
  List<ClubBanner> banners;

  PartnerBanners({
    this.partner,
    this.banners,
  });

  static Map<String, dynamic> toJson(PartnerBanners bp) => null;
  //null != bp ? _$PartnerBannersToJson(bp) : null;

  static PartnerBanners fromJson(Map<String, dynamic> json) => null;
  //null != json ? _$PartnerBannersFromJson(json) : null;
}

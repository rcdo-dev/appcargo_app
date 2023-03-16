// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_banners.dart';

PartnerBanners _$PartnerBannersFromJson(Map<String, dynamic> json) {
  return PartnerBanners(
    partner: ClubPartner.fromJson(json['partner']),
    banners: (json['banners'] as List<dynamic>).map((json) => ClubBanner.fromJson(json)).toList(growable: false),
  );
}

Map<String, dynamic> _$PartnerBannersToJson(PartnerBanners instance) =>
    <String, dynamic> {
      'partner': instance.partner,
      'banners': instance.banners,
    };

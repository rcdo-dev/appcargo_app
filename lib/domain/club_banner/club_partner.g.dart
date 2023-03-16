// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_partner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubPartner _$BannerPartnerFromJson(Map<String, dynamic> json) {
  return ClubPartner(
    hash: json['hash'] as String,
    name: json['name'] as String,
    photo: json['photo'] as String,
    logoToShowOnAppBannersPage: json['logoToShowOnAppBannersPage'] as String,
    bannerQuantity: json['bannerQuantity'] as int,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$BannerPartnerToJson(ClubPartner instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'name': instance.name,
      'photo': instance.photo,
      'logoToShowOnAppBannersPage': instance.logoToShowOnAppBannersPage,
      'bannerQuantity': instance.bannerQuantity,
      'description': instance.description,
    };

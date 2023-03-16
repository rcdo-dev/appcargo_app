// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeBanner _$HomeBannerFromJson(Map<String, dynamic> json) {
  return HomeBanner(
    hash: json['hash'] as String,
    photo: json['photo'] as String,
    link: json['link'] as String,
  );
}

Map<String, dynamic> _$HomeBannerToJson(HomeBanner instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'photo': instance.photo,
      'link': instance.link,
    };

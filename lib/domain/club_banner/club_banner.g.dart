// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubBanner _$ClubBannerFromJson(Map<String, dynamic> json) {
  return ClubBanner(
    hash: json['hash'] as String,
    photo: json['photo'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    link: json['link'] as String,
    size: json['size'] as String,
  );
}

Map<String, dynamic> _$ClubBannerToJson(ClubBanner instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'photo': instance.photo,
      'title': instance.title,
      'description': instance.description,
      'link': instance.link,
      'size': instance.size,
    };

import 'package:json_annotation/json_annotation.dart';

part 'club_banner.g.dart';

@JsonSerializable()
class ClubBanner {
  String hash;
  String photo;
  String title;
  String description;
  String link;
  String size;

  ClubBanner({
    this.hash,
    this.photo,
    this.title,
    this.description,
    this.link,
    this.size,
  });

  static Map<String, dynamic> toJson(ClubBanner bp) =>
      null != bp ? _$ClubBannerToJson(bp) : null;

  static ClubBanner fromJson(Map<String, dynamic> json) =>
      null != json ? _$ClubBannerFromJson(json) : null;
}

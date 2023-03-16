import 'package:json_annotation/json_annotation.dart';

part 'home_banner.g.dart';

@JsonSerializable()
class HomeBanner {
  String hash;
  String photo;
  String link;


  HomeBanner({this.hash, this.photo, this.link});

  static Map<String, dynamic> toJson(HomeBanner homeBanner) {
    return _$HomeBannerToJson(homeBanner);
  }

  static HomeBanner fromJson(Map<String, dynamic> json) {
    return _$HomeBannerFromJson(json);
  }
}

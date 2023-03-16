
part 'media.g.dart';

class Media {

  String url;
  String contentType;

  Media({this.url, this.contentType});

  static Map<String, dynamic> toJson(Media instance) {
    return _$MediaToJson(instance);
  }

  static Media fromJson(Map<String, dynamic> json) {
    return _$MediaFromJson(json);
  }
}
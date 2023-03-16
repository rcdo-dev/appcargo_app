part 'header_security.g.dart';

class HeaderSecurity {
  String hash;
  String parameters;
  String key;

  HeaderSecurity({this.hash, this.parameters, this.key});

  static Map<String, dynamic> toJson(HeaderSecurity instance) {
    return _$HeaderSecurityToJson(instance);
  }

  static HeaderSecurity fromJson(Map<String, dynamic> json) {
    return _$HeaderSecurityFromJson(json);
  }
}

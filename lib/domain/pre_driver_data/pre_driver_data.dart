import 'package:app_cargo/http/transformers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pre_driver_data.g.dart';

@JsonSerializable()
class PreDriverData {
  String alias;
  String email;
  String cellNumber;
  String password;

  PreDriverData({this.alias, this.email, this.cellNumber, this.password});

  static Map<String, dynamic> toJson(PreDriverData domain) {
    return _$DriverSignUpToJson(domain);
  }

  static PreDriverData fromJson(Map<String, dynamic> json) {
    return _$PreDriverDataFromJson(json);
  }
}

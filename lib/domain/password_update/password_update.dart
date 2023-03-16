import 'package:json_annotation/json_annotation.dart';

part 'password_update.g.dart';

@JsonSerializable()
class PasswordUpdate {
  String oldPassword;
  String newPassword;
  String repeatNewPassword;

  PasswordUpdate({this.newPassword, this.oldPassword, this.repeatNewPassword});

  static Map<String, dynamic> toJson(PasswordUpdate passwordUpdate) {
    return _$PasswordUpdateToJson(passwordUpdate);
  }

  static PasswordUpdate fromJson(Map<String, dynamic> json) {
    return _$PasswordUpdateFromJson(json);
  }
}

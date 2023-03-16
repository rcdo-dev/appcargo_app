import 'package:json_annotation/json_annotation.dart';

part 'login_and_password.g.dart';

@JsonSerializable()
class LoginAndPassword {
  String login;
  String password;

  LoginAndPassword({
    this.password,
    this.login,
  });

  String toJson(LoginAndPassword loginAndPassword) {
    return _$LoginAndPasswordToJson(loginAndPassword).toString();
  }

  factory LoginAndPassword.fromJson(Map<String, dynamic> json) {
    return _$LoginAndPasswordFromJson(json);
  }
}

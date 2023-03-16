import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  int luckyNumber;
  String accessToken;
  String hash;
  String role;

  LoginResponse({
    this.accessToken,
    this.hash,
    this.role,
    this.luckyNumber,
  });

  String toJson(LoginResponse loginResponse) {
    return _$LoginResponseToJson(loginResponse).toString();
  }

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseFromJson(json);
  }
}

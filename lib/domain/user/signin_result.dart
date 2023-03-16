import 'package:json_annotation/json_annotation.dart';

part 'signin_result.g.dart';

@JsonSerializable()
class SigninResultDTO {
  final String accessToken;

  SigninResultDTO({this.accessToken});

  factory SigninResultDTO.fromJson(Map<String, dynamic> json) {
    return _$SigninResultDTOFromJson(json);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_and_password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginAndPassword _$LoginAndPasswordFromJson(Map<String, dynamic> json) {
  return LoginAndPassword(
    password: json['password'] as String,
    login: json['login'] as String,
  );
}

Map<String, dynamic> _$LoginAndPasswordToJson(LoginAndPassword instance) =>
    <String, dynamic>{
      'login': instance.login,
      'password': instance.password,
    };

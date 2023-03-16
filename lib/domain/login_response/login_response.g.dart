// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse(
    accessToken: json['accessToken'] as String,
    hash: json['hash'] as String,
    role: json['role'] as String,
    luckyNumber: json['luckyNumber'] as int,
  );
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'luckyNumber': instance.luckyNumber,
      'accessToken': instance.accessToken,
      'hash': instance.hash,
      'role': instance.role,
    };

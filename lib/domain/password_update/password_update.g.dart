// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordUpdate _$PasswordUpdateFromJson(Map<String, dynamic> json) {
  return PasswordUpdate(
    newPassword: json['newPassword'] as String,
    oldPassword: json['oldPassword'] as String,
    repeatNewPassword: json['repeatNewPassword'] as String,
  );
}

Map<String, dynamic> _$PasswordUpdateToJson(PasswordUpdate instance) =>
    <String, dynamic>{
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
      'repeatNewPassword': instance.repeatNewPassword,
    };

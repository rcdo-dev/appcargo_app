// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_driver_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreDriverData _$PreDriverDataFromJson(Map<String, dynamic> json) {
  return PreDriverData(
    alias: json['alias'] as String,
    email: json['email'] as String,
    cellNumber: json['cellNumber'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$DriverSignUpToJson(PreDriverData instance) =>
    <String, dynamic>{
      'alias': instance.alias,
      'email': instance.email,
      'cellNumber': genericStringCleaner(instance.cellNumber),
      'password': instance.password,
    } ;

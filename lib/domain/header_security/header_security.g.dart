// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'header_security.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeaderSecurity _$HeaderSecurityFromJson(Map<String, dynamic> json) {
  return HeaderSecurity(
    hash: json['hash'] as String,
    parameters: json['parameters'] as String,
    key: json['key'] as String,
  );
}

Map<String, dynamic> _$HeaderSecurityToJson(HeaderSecurity instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'parameters': instance.parameters,
      'key': instance.key,
    };

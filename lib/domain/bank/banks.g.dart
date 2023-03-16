// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Banks _$BanksFromJson(Map<String, dynamic> json) {
  return Banks(
    banks: Banks.fromBanksJson(json['banks'] as List),
  );
}

Map<String, dynamic> _$BanksToJson(Banks instance) => <String, dynamic>{
      'banks': instance.banks,
    };

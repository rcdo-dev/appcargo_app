// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_personal_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverPersonalData _$DriverPersonalDataFromJson(Map<String, dynamic> json) {
  return DriverPersonalData(
    personalPhotoUrl: json['personalPhotoUrl'] as String,
    hasMope: json['hasMope'] as bool,
    hasMercoSulPermission: json['hasMercoSulPermission'] as bool,
    hasMEI: json['hasMEI'] as bool,
    birthDate: json['birthDate'] as String,
    registry: json['registry'] as String,
    nationalId: json['nationalId'] as String,
    name: json['name'] as String,
    alias: json['alias'] as String,
    previousFreightCompanies: (json['previousFreightCompanies'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    references: (json['references'] as List)?.map((e) => e as String)?.toList(),
    driverLicense:
        DriverLicense.fromJson(json['driverLicense'] as Map<String, dynamic>),
    rntrc: json['rntrc'] as String,
    bank: Bank.fromJson(json['bank'] as Map<String, dynamic>),
    account: json['account'] as String,
    branch: json['branch'] as String,
    premium: json['premium'] as bool,
  );
}

Map<String, dynamic> _$DriverPersonalDataToJson(DriverPersonalData instance) =>
    <String, dynamic>{
      'personalPhotoUrl': instance.personalPhotoUrl,
      'alias': instance.alias,
      'name': instance.name,
      'nationalId': genericStringCleaner(instance.nationalId),
      'registry': genericStringCleaner(instance.registry),
      'birthDate': instance.birthDate,
      'rntrc': instance.rntrc,
      'hasMope': instance.hasMope,
      'hasMercoSulPermission': instance.hasMercoSulPermission,
      'hasMEI': instance.hasMEI,
      'driverLicense': DriverLicense.toJson(instance.driverLicense),
      'references': DriverPersonalData.toJsonListString(instance.references),
      'previousFreightCompanies': instance.previousFreightCompanies,
      'branch': instance.branch,
      'account': instance.account,
      'bank': Bank.toJson(instance.bank),
      'premium': instance.premium,
    };

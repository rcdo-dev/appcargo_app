// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_license.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverLicense _$DriverLicenseFromJson(Map<String, dynamic> json) {
  return DriverLicense(
    number: json['number'] as String,
    expirationDate: json['expirationDate'] as String,
    classification:
        DriverLicenseCategory.fromJson(json['classification'] as String),
    extras: json['extras'] as String,
  );
}

Map<String, dynamic> _$DriverLicenseToJson(DriverLicense instance) =>
    <String, dynamic>{
      'number': genericStringCleaner(instance.number),
      'expirationDate': instance.expirationDate,
      'classification': DriverLicenseCategory.toJson(instance.classification),
      'extras': instance.extras,
    };

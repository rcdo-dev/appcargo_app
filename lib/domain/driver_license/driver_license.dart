import 'dart:io';

import 'package:app_cargo/constants/enum.dart';
import 'package:app_cargo/http/transformers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver_license.g.dart';

@JsonSerializable()
class DriverLicense {
  @JsonKey(toJson: genericStringCleaner)
  String number;
  String expirationDate;

  @JsonKey(
      toJson: DriverLicenseCategory.toJson,
      fromJson: DriverLicenseCategory.fromJson)
  DriverLicenseCategory classification;

  @JsonKey(ignore: true)
  File photo;

  String extras;

  DriverLicense({
    this.number,
    this.expirationDate,
    this.classification,
    this.extras,
  });

  static Map<String, dynamic> toJson(DriverLicense driverLicense) {
    return _$DriverLicenseToJson(driverLicense);
  }

  static DriverLicense fromJson(Map<String, dynamic> json) {
    return _$DriverLicenseFromJson(json);
  }
}

class DriverLicenseCategory implements NamedEnum {
  final String _name;

  const DriverLicenseCategory._(this._name);

  @override
  String name() => _name;

  @override
  String uniqueName() => _name;
  
  static String toJson(DriverLicenseCategory type) {
    if(type != null )
      return type.name();
    return null;
  }

  static DriverLicenseCategory fromJson(String val) =>
      DriverLicenseCategoryHelper().from(val);

  static const B = DriverLicenseCategory._("B");
  static const C = DriverLicenseCategory._("C");
  static const D = DriverLicenseCategory._("D");
  static const E = DriverLicenseCategory._("E");
}

class DriverLicenseCategoryHelper extends EnumHelper<DriverLicenseCategory> {
  @override
  List<DriverLicenseCategory> values() => [
        DriverLicenseCategory.B,
        DriverLicenseCategory.C,
        DriverLicenseCategory.D,
        DriverLicenseCategory.E,
      ];
}

import 'dart:io';

import 'package:app_cargo/domain/bank/bank.dart';
import 'package:app_cargo/domain/driver_license/driver_license.dart';
import 'package:app_cargo/http/transformers.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../constants/enum.dart';

part 'driver_personal_data.g.dart';

@JsonSerializable()
class DriverPersonalData {
  @JsonKey(ignore: true)
  File personalPhoto;
  String personalPhotoUrl;
  String alias;
  String name;
  @JsonKey(toJson: genericStringCleaner)
  String nationalId;
  @JsonKey(toJson: genericStringCleaner)
  String registry;
  String birthDate;
  String rntrc;
  bool hasMope;
  bool hasMercoSulPermission;
  bool hasMEI;
  @JsonKey(toJson: DriverLicense.toJson, fromJson: DriverLicense.fromJson)
  DriverLicense driverLicense;
  @JsonKey(toJson: DriverPersonalData.toJsonListString)
  List<String> references;
  List<String> previousFreightCompanies;
  String branch;
  String account;
  @JsonKey(fromJson: Bank.fromJson, toJson: Bank.toJson)
  Bank bank;
  bool premium;

  DriverPersonalData(
      {this.personalPhotoUrl,
      this.hasMope,
      this.hasMercoSulPermission,
      this.hasMEI,
      this.birthDate,
      this.registry,
      this.nationalId,
      this.name,
      this.alias,
      this.personalPhoto,
      this.previousFreightCompanies,
      this.references,
      this.driverLicense,
      this.rntrc,
      this.bank,
      this.account,
      this.branch,
      this.premium});

  Map<String, File> get files => {
        if (null != personalPhoto) 'personalPhoto': personalPhoto,
      };

  static Map<String, dynamic> toJson(DriverPersonalData driverPersonalData) {
    return _$DriverPersonalDataToJson(driverPersonalData);
  }

  static DriverPersonalData fromJson(Map<String, dynamic> json) {
    return _$DriverPersonalDataFromJson(json);
  }

  static List<String> toJsonListString(List<String> stringList) {
    List<String> cleanedStrings = new List<String>();
    for (String string in stringList) {
      cleanedStrings.add(genericStringCleaner(string));
    }

    return cleanedStrings;
  }
}

class GenderType implements NamedEnum {
  final String _name;
  final String _jsonName;

  const GenderType._(this._jsonName, this._name);

  @override
  String name() => _name;

  @override
  String uniqueName() => _jsonName;

  static String toJson(GenderType type) => null != type ? type._jsonName : null;

  static GenderType fromJson(String val) => GenderTypeHelper().from(val);

  static const MALE = GenderType._("MALE", "Masculino");
  static const FEMALE = GenderType._("FEMALE", "Feminino");
  static const NON_SPECIFIED =
      GenderType._("NON_SPECIFIED", "Não Especificado");
}

class GenderTypeHelper extends EnumHelper<GenderType> {
  @override
  List<GenderType> values() => [
        GenderType.MALE,
        GenderType.FEMALE,
        GenderType.NON_SPECIFIED,
      ];
}

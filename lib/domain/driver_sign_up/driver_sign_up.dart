import 'package:app_cargo/domain/fipe_brand/fipe_brand.dart';
import 'package:app_cargo/domain/fipe_model_summary/fipe_model_summary.dart';
import 'package:app_cargo/domain/fipe_model_year_summary/fipe_model_year_summary.dart';
import 'package:app_cargo/domain/truck/truck.dart';
import 'package:app_cargo/http/transformers.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver_sign_up.g.dart';

@JsonSerializable()
class DriverSignUp {
  // First Step
  String alias;
  @JsonKey(toJson: genericStringCleaner)
  String cellNumber;

  // Second Step
  @JsonKey(toJson: dateToJson, fromJson: dateFromJson)
  DateTime birthDate;
  @JsonKey(toJson: genericStringCleaner)
  String nationalId;
  String email;
  @JsonKey(fromJson: TruckType.fromJson, toJson: TruckType.toJson)
  TruckType truckType;
  String password;

  // Third Step
  @JsonKey(fromJson: TrailerType.fromJson, toJson: TrailerType.toJson)
  TrailerType trailerType;
  String modelFipeId;
  String modelYearFipeId;
  String makeFipeId;
  @JsonKey(fromJson: TruckAxles.fromJson, toJson: TruckAxles.toJson)
  TruckAxles axles;

  // Fourth Step
  @JsonKey(toJson: genericStringCleaner)
  String truckPlate;
  @JsonKey(toJson: genericStringCleaner)
  String trailerPlate1;
  @JsonKey(toJson: genericStringCleaner)
  String trailerPlate2;
  bool hasCarTracker;
  bool hasMope;
  bool hasMEI;

  DriverSignUp({
    // First Step
    this.alias,
    this.cellNumber,

    // Second Step
    this.birthDate,
    this.nationalId,
    this.email,
    this.truckType,
    this.password,

    // Third Step
    this.trailerType,
    this.modelYearFipeId,
    this.modelFipeId,
    this.makeFipeId,
    this.axles,

    // Fourth Step
    this.truckPlate,
    this.trailerPlate1,
    this.trailerPlate2,
    this.hasCarTracker,
    this.hasMope,
    this.hasMEI
  });

  static Map<String, dynamic> toJson(DriverSignUp driverSignUp) {
    return _$DriverSignUpToJson(driverSignUp);
  }

  static DriverSignUp fromJson(Map<String, dynamic> json) {
    return _$DriverSignUpFromJson(json);
  }
}

import 'package:app_cargo/domain/driver_sign_up/driver_sign_up.dart';
import 'package:app_cargo/domain/fipe_brand/fipe_brand.dart';
import 'package:app_cargo/domain/fipe_model_summary/fipe_model_summary.dart';
import 'package:app_cargo/domain/fipe_model_year_summary/fipe_model_year_summary.dart';
import 'package:app_cargo/domain/make_type.dart';
import 'package:app_cargo/domain/pre_driver_data/pre_driver_data.dart';
import 'package:app_cargo/domain/truck/truck.dart';
import 'package:app_cargo/http/transformers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class SignUpController with ChangeNotifier {
  bool hasReadTermsAndConditions = false;

  // First Step
  TextEditingController alias;
  MaskedTextController cellNumber;

  MaskedTextController birthDate;
  MaskedTextController nationalId;
  TextEditingController email;

  // Second Step
  TruckType truckType;
  MakeType makeType;

  // Third Step
  TrailerType trailerType;
  FipeModelSummary model;
  FipeModelYearSummary modelYear;
  FipeBrand brand;
  TruckAxles axles;

  // Fourth Step
  MaskedTextController truckPlate;
  MaskedTextController trailerPlate1;
  MaskedTextController trailerPlate2;
  bool hasMope;
  bool hasCarTracker;
  bool hasMEI;

  SignUpController() {
    // First Step
    this.alias = new TextEditingController();
    this.cellNumber =
        new MaskedTextController(mask: "(00) 00000-0000", text: "");

    this.birthDate = new MaskedTextController(mask: "00/00/0000", text: "");
    this.nationalId =
        new MaskedTextController(mask: "000.000.000-00", text: "");
    this.email = new TextEditingController();

    // Second Step
    this.truckType = null;
    this.makeType = null;

    // Third Step
    this.trailerType = null;
    this.model = null;
    this.modelYear = null;
    this.brand = null;
    this.axles = null;

    // Fourth Step
    this.truckPlate = new MaskedTextController(mask: "AAA0@00");
    this.trailerPlate1 = new MaskedTextController(mask: "AAA0@00");
    this.trailerPlate2 = new MaskedTextController(mask: "AAA0@00");
    this.hasMope = false;
    this.hasCarTracker = false;
    this.hasMEI = false;
  }

  DriverSignUp getDriverSingUp() {
    return new DriverSignUp(
      // First Step
      alias: this.alias.text,
      cellNumber: this.cellNumber.text,

      // Second Step
      birthDate: dateFromJson(this.birthDate.text),
      nationalId: this.nationalId.text,
      email: this.email.text,
      truckType: this.truckType,
      password: this.birthDate.text.replaceAll("/", ""),

      // Third Step
      trailerType: this.trailerType,
      modelFipeId: this.model.id,
      modelYearFipeId: this.modelYear.id,
      makeFipeId: this.brand.id,
      axles: this.axles,

      // Fourth Step
      truckPlate: this.truckPlate.text,
      trailerPlate1: this.trailerPlate1.text.trim().length > 0
          ? this.trailerPlate1.text
          : null,
      trailerPlate2: this.trailerPlate2.text.trim().length > 0
          ? this.trailerPlate2.text
          : null,
      hasMope: this.hasMope,
      hasCarTracker: this.hasCarTracker,
      hasMEI: this.hasMEI,
    );
  }

  PreDriverData getPreDriverData() {
    return PreDriverData(
      alias: this.alias.text,
      cellNumber: this.cellNumber.text ?? "",
      email: this.email.text,
    );
  }

  void fillWithFakeData() {
    this.alias.text = "Ioxua";
    this.cellNumber.text = "(11) 95910-1278";
    this.hasReadTermsAndConditions = true;

    this.birthDate.text = "02/01/1999";
    this.nationalId.text = "465.343.088-86";
    this.email.text = "ioxua.oliveira@gmail.com";
    this.truckType = null;

    this.truckPlate.text = "abc1232";
    this.trailerPlate1.text = "";
    this.trailerPlate2.text = "";
    this.hasMope = false;
    this.hasCarTracker = false;
    this.hasMEI = false;
    this.trailerType = null;
    this.brand = null;
    this.model = null;
    this.modelYear = null;
    this.axles = null;
  }
}

import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/analytics_events_constants.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/fipe_brand/fipe_brand.dart';
import 'package:app_cargo/domain/fipe_model_summary/fipe_model_summary.dart';
import 'package:app_cargo/domain/fipe_model_year_summary/fipe_model_year_summary.dart';
import 'package:app_cargo/domain/truck/truck.dart';
import 'package:app_cargo/screens/signup/signup_base_step.dart';
import 'package:app_cargo/screens/signup/signup_controller.dart';
import 'package:app_cargo/screens/signup/widget/app_axles_and_trailer_select.dart';
import 'package:app_cargo/screens/signup/widget/dynamic_check_box.dart';
import 'package:app_cargo/widgets/app_fipe_data.dart';
import 'package:app_cargo/widgets/app_text.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SignUpStep3 extends SignUpStep {

  @override
  Widget buildContent(BuildContext context) {
    return Consumer<SignUpController>(builder: (context, signUpController, _) {
      signUpController.trailerType = null;
      signUpController.axles = null;
      signUpController.model = null;
      signUpController.modelYear = null;
      signUpController.brand = null;
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      title: AppText(
                        "Informações sobre o Caminhão",
                        weight: FontWeight.bold,
                        textColor: AppColors.green,
                        textAlign: TextAlign.center,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppAxlesAndTrailerSelect(
              signUpController.truckType,
              onAxlesChanged: (axles) {
                signUpController.axles = axles;
              },
              onTrailerTypeChanged: (trailerType) {
                signUpController.trailerType = trailerType;
              },
            ),
            AppFipeData(
              selectedMakeType: signUpController.makeType,
              selectedBrand: signUpController.brand,
              selectedModel: signUpController.model,
              selectedModelYear: signUpController.modelYear,
              onBrandChanged: (brand) {
                signUpController.brand = brand;
                signUpController.model = null;
                signUpController.modelYear = null;
              },
              onModelYearChanged: (modelYear) {
                signUpController.modelYear = modelYear;
                signUpController.model = null;
              },
              onModelChanged: (model) {
                signUpController.model = model;
              },
            ),
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DynamicCheckBox(
                      "Tem rastreador", signUpController.hasCarTracker,
                      onChanged: (bool flag) {
                        signUpController.hasCarTracker = flag;
                      },),
                  DynamicCheckBox(
                    "Tem MOPP",
                    signUpController.hasMope,
                    onChanged: (bool flag) {
                      signUpController.hasMope = flag;
                    },
                  ),
                  DynamicCheckBox(
                    "Tem MEI",
                    signUpController.hasMEI,
                    onChanged: (bool flag) {
                      signUpController.hasMEI = flag;
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Future<bool> validate(SignUpController signUpController, BuildContext context) {
    TruckType truckType = signUpController.truckType;
    FipeBrand brand = signUpController.brand;
    FipeModelYearSummary modelYear = signUpController.modelYear;
    FipeModelSummary model = signUpController.model;
    TrailerType trailerType = signUpController.trailerType;
    TruckAxles axles = signUpController.axles;

    if (null == truckType ||
        null == brand ||
        null == modelYear ||
        null == model ||
        (null == trailerType && null == axles) ||
        (null == trailerType && axles != TruckAxles.CAVALO_MECANICO && axles != null)) {
      showMessageDialog(context,
          message: "Preencha todos os campos corretamente");
      return Future.value(false);
    }

    facebookAppEvents.logEvent(
        name: AnalyticsEventsConstants.signupStep03);
    firebaseAnalytics.logEvent(name: AnalyticsEventsConstants.signupStep03);

    return Future.value(true);
  }
}

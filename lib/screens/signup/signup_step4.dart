import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/analytics_events_constants.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/truck/truck.dart';
import 'package:app_cargo/screens/signup/signup_base_step.dart';
import 'package:app_cargo/screens/signup/signup_controller.dart';
import 'package:app_cargo/screens/signup/widget/dynamic_check_box.dart';
import 'package:app_cargo/widgets/app_text_field.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SignUpStep4 extends SignUpStep {
  @override
  Widget buildContent(BuildContext context) {
    return Consumer<SignUpController>(
      builder: (context, signUpController, _) {
        return Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[

                  if (null != signUpController.axles &&
                      null != signUpController.trailerType)
                    AppTextField(
                      label:
                          "Placa da 1º carroceria (somente caracteres e números)",
                      labelColor: AppColors.blue,
                      hint: "Digite a placa da 1º carroceria",
                      prefixIcon: Icon(
                        Icons.local_shipping,
                        color: AppColors.yellow,
                      ),
                      textEditingController: signUpController.trailerPlate1,
                      inputType: TextInputType.text,
                    ),
                  if (null != signUpController.axles &&
                      null != signUpController.trailerType)
                    AppTextField(
                      label:
                          "Placa da 2º carroceria (somente caracteres e números)",
                      labelColor: AppColors.blue,
                      hint: "Digite a placa da 2º carroceria",
                      prefixIcon: Icon(
                        Icons.local_shipping,
                        color: AppColors.yellow,
                      ),
                      textEditingController: signUpController.trailerPlate2,
                      inputType: TextInputType.text,
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Future<bool> validate(
      SignUpController signUpController, BuildContext context) {


    facebookAppEvents.logEvent(name: AnalyticsEventsConstants.signupStep04);
    firebaseAnalytics.logEvent(name: AnalyticsEventsConstants.signupStep04);

    return Future.value(true);
  }
}

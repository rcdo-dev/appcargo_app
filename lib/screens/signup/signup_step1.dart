import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/build_data.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/constants/analytics_events_constants.dart';
import 'package:app_cargo/constants/endpoints.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/screens/signup/signup_base_step.dart';
import 'package:app_cargo/screens/signup/signup_controller.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_switch.dart';
import 'package:app_cargo/widgets/app_text.dart';
import 'package:app_cargo/widgets/app_text_button.dart';
import 'package:app_cargo/widgets/app_text_field.dart';
import 'package:app_cargo/widgets/app_text_field_second_ui.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpStep1 extends SignUpStep {


  @override
  Widget buildContent(BuildContext context) {
    return Consumer<SignUpController>(
      builder: (context, signUpController, _) {
        return Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[
              Container(
                  child: Card(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: AppText(
                        "Preencha os campos e clique em continuar para avançar para o próximo",
                        weight: FontWeight.bold,
                        textColor: AppColors.black,
                        textAlign: TextAlign.center,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: AppText(
                        "Você está a 3 passos de receber diversas cargas!",
                        weight: FontWeight.bold,
                        textColor: AppColors.green,
                        textAlign: TextAlign.center,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )),
              AppTextFieldSecondUI(
                label: "Placa",
                labelColor: AppColors.dark_grey02,
                labelSize: 14,
                labelBold: FontWeight.bold,
                hint: "Digite a placa do seu caminhão",
                textEditingController: signUpController.truckPlate,
                inputType: TextInputType.text,
              ),
              AppTextFieldSecondUI(
                label: "Nome",
                labelColor: AppColors.dark_grey02,
                labelSize: 14,
                labelBold: FontWeight.bold,
                hint: "Nome do Motorista",
                textEditingController: signUpController.alias,
                inputType: TextInputType.text,
              ),
              AppTextFieldSecondUI(
                label: "E-Mail",
                labelColor: AppColors.dark_grey02,
                labelSize: 14,
                labelBold: FontWeight.bold,
                hint: "motorista@gmail.com",
                textEditingController: signUpController.email,
                inputType: TextInputType.emailAddress,
              ),
              Column(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        children: <Widget>[
                          AppSwitch(
                            value: signUpController.hasReadTermsAndConditions,
                            onChange: (bool value) {
                              signUpController.hasReadTermsAndConditions =
                                  value;
                            },
                          ),
                          AppText.fieldLabel(
                            "Li e concordo com os ",
                            fontSize: 13,
                            textColor: AppColors.dark_grey02,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (await canLaunch(Endpoints.termsOfUse)) {
                                await launch(Endpoints.termsOfUse);
                              } else {
                                // TODO: VISUAL FEEDBACK ON NOT BEING ABLE TO LAUNCH THE PDF
                              }
                            },
                            child: Text(
                              "Termos de Uso",
                              style: TextStyle(
                                color: AppColors.light_blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Text(" e "),
                          GestureDetector(
                            onTap: () async {
                              if (await canLaunch(Endpoints.policyPrivacyUrl)) {
                                await launch(Endpoints.policyPrivacyUrl);
                              } else {
                                // TODO: VISUAL FEEDBACK ON NOT BEING ABLE TO LAUNCH THE PDF
                              }
                            },
                            child: Text(
                              "Política de Privacidade",
                              style: TextStyle(
                                color: AppColors.light_blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (BuildData.isDebugMode)
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
                  child: Column(
                    children: <Widget>[
                      AppSaveButton(
                        "PREENCHER",
                        onPressed: () {
                          signUpController.fillWithFakeData();
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Future<bool> validate(
      SignUpController signUpController, BuildContext context) async {
    //*************************************************************************

    String truckPlate = signUpController.truckPlate.text.trim();

    if (truckPlate.length <= 0) {
      showMessageDialog(context,
          type: DialogType.WARNING,
          message: "A placa do caminhão é obrigatória");
      return Future.value(false);
    }

    //*************************************************************************

    String driverAlias = signUpController.alias.text.trim();

    if (driverAlias.length < 1) {
      showMessageDialog(context, message: "O nome deve ser preenchido");
      return false;
    }

    //*************************************************************************

    // E-mail validations
    String email = signUpController.email.text.trim();

    if (!RegExp(
            r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$')
        .hasMatch(email)) {
      showMessageDialog(context, message: "Preencha corretamente o email");
      return false;
    }

    //*************************************************************************

    if (!signUpController.hasReadTermsAndConditions) {
      showMessageDialog(context,
          message:
              "Você deve ler e concordar com os termos e condições de uso.");
      return false;
    }

    driverService
        .savePreDriverData(signUpController.getPreDriverData())
        .then((value) {
      return true;
    });

    //*************************************************************************

    facebookAppEvents.setUserData(firstName: driverAlias, email: email);
    facebookAppEvents.logEvent(name: AnalyticsEventsConstants.signupStep01);
    firebaseAnalytics.logEvent(name: AnalyticsEventsConstants.signupStep01);

    //*************************************************************************

    return true;
  }
}

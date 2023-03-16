import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/analytics_events_constants.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/make_type.dart';
import 'package:app_cargo/domain/truck/truck.dart';
import 'package:app_cargo/screens/signup/signup_base_step.dart';
import 'package:app_cargo/screens/signup/signup_controller.dart';
import 'package:app_cargo/widgets/app_text.dart';
import 'package:app_cargo/widgets/app_text_field.dart';
import 'package:app_cargo/widgets/app_text_field_second_ui.dart';
import 'package:app_cargo/widgets/app_truck_select.dart';
import 'package:app_cargo/widgets/app_truck_select_second_ui.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';
import 'package:provider/provider.dart';

class SignUpStep2 extends SignUpStep {

  @override
  Widget buildContent(BuildContext context) {
    return Consumer<SignUpController>(builder: (context, signUpController, _) {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      title: AppText(
                        "Dados do Caminhoneiro",
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
            AppTextFieldSecondUI(
              label: "Data de nascimento",
              labelColor: AppColors.dark_grey02,
              labelSize: 14,
              labelBold: FontWeight.bold,
              hint: "00/00/0000",
              textEditingController: signUpController.birthDate,
              inputType: TextInputType.datetime,
            ),
            AppTextFieldSecondUI(
              label: "CPF",
              labelColor: AppColors.dark_grey02,
              labelSize: 14,
              labelBold: FontWeight.bold,
              hint: "000.000.000-00",
              textEditingController: signUpController.nationalId,
              inputType: TextInputType.number,
            ),

            AppTextFieldSecondUI(
              label: "Celular",
              labelColor: AppColors.dark_grey02,
              labelSize: 14,
              labelBold: FontWeight.bold,
              hint: "(00) 0.0000-0000",
              textEditingController: signUpController.cellNumber,
              inputType: TextInputType.phone,
            ),

            Container(
              padding: EdgeInsets.only(bottom: 10),
              alignment: Alignment.topLeft,
              child: SkyText(
                "Tipo do caminhão",
                fontSize: 14,
                fontWeight: FontWeight.bold,
                textColor: AppColors.dark_grey02,
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 30),
              child: AppTruckTypeWidgetSecondUI(
                onChanged: (truckType) {
                  signUpController.truckType = truckType;
                  if (truckType == TruckType.UTILITARIO) {
                    signUpController.makeType = MakeType.car_or_utilitary;
                  } else {
                    signUpController.makeType = MakeType.truck;
                  }
                },
                defaultValue: signUpController.truckType,
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Future<bool> validate(
      SignUpController signUpController, BuildContext context) async {
    //*************************************************************************

    // Birth date validations
    String birthDateText = signUpController.birthDate.text.trim();
    List<String> birthDateFields = birthDateText.split("/");

    if (birthDateFields.length == 3) {
      try {
        DateTime birthDate = DateTime.parse(birthDateFields[2] +
            "-" +
            birthDateFields[1] +
            "-" +
            birthDateFields[0]);
        if (DateTime.now().year - birthDate.year <= 18) {
          showMessageDialog(context,
              message: "É necessário ser maior de 18 anos para se registrar.");
          return false;
        }
      } catch (e) {
        showMessageDialog(context,
            message: "Informe uma data de nascimento válida.");
        return false;
      }
    } else {
      showMessageDialog(context,
          message: "A data de nascimento é obrigatória.");
      return false;
    }

    //*************************************************************************

    // CPF validations
    String nationalId = signUpController.nationalId.text.trim();

    if (nationalId.length > 0 && nationalId.length < 14) {
      String nationalIdStripped = CPFValidator.strip(nationalId);
      String newNationalId = "";
      for (int i = 0; i < 11 - nationalIdStripped.length; i++) {
        newNationalId += '0';
      }
      newNationalId += nationalIdStripped;

      newNationalId = CPFValidator.format(newNationalId);

      showMessageDialog(context,
          message:
              "CPF informado $nationalId é muito curto, assumimos que você quis dizer que o CPF é $newNationalId, confira o CPF novamente e prossiga com o cadastro.");

      nationalId = newNationalId;

      signUpController.nationalId.text = nationalId;
      return false;
    }

    if (!CPFValidator.isValid(nationalId)) {
      showMessageDialog(context, message: "O CPF $nationalId é inválido");
      return false;
    }

    //*************************************************************************

    String cellNumber = signUpController.cellNumber.text.trim();

    if (cellNumber.length < 15) {
      showMessageDialog(context, message: "Preencha corretamente o telefone");
      return false;
    }

    int dddNumber = int.parse(cellNumber.substring(1, 3));

    if (dddNumber < 11 || dddNumber > 99) {
      showMessageDialog(context, message: "O DDD precisa estar entre 11 e 99");
      return false;
    }

    //*************************************************************************

    // Truck Type validations
    TruckType truckType = signUpController.truckType;

    if (null == truckType) {
      showMessageDialog(context, message: "Selecione um tipo de caminhão");
      return false;
    }

    //*************************************************************************

    facebookAppEvents.setUserData(dateOfBirth: birthDateText);
    facebookAppEvents.logEvent(name: AnalyticsEventsConstants.signupStep02);
    firebaseAnalytics.logEvent(name: AnalyticsEventsConstants.signupStep02);


    return true;
  }
}

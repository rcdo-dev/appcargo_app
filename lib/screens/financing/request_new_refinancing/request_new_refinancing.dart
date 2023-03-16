import 'dart:developer';

import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/omni/new_proposal_requrest/simulation.dart'
    as omni;
import 'package:app_cargo/domain/profile_summary/profile_summary.dart';
import 'package:app_cargo/routes.dart';
import 'package:app_cargo/screens/financing/request_new_refinancing/request_new_refinancing_controller.dart';
import 'package:app_cargo/screens/financing/widgets/app_state_dropdown_button.dart';
import 'package:app_cargo/screens/financing/widgets/refinancing_modal.dart';
import 'package:app_cargo/services/me/me_service.dart';
import 'package:app_cargo/services/omni/omni_service.dart';
import 'package:app_cargo/widgets/app_dropdown_button.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_save_button_second_ui.dart';
import 'package:app_cargo/widgets/app_text.dart';
import 'package:app_cargo/widgets/app_text_button.dart';
import 'package:app_cargo/widgets/app_text_field_second_ui.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class RequestNewRefinancing extends StatefulWidget {
  @override
  _RequestNewRefinancingState createState() => _RequestNewRefinancingState();
}

class _RequestNewRefinancingState extends State<RequestNewRefinancing> {
  final RequestNewRefinancingController _refinancingController =
      new RequestNewRefinancingController();
  final OmniService _omniService = DIContainer().get<OmniService>();
  final MeService _meService = DIContainer().get<MeService>();

  @override
  void initState() {
    super.initState();

    _meService.getAllDriverData().then((ProfileSummary profileSummary) {
      if (profileSummary.personal != null) {
        _refinancingController.itin.text =
            profileSummary.personal.nationalId ?? '';
        _refinancingController.birthDate.text =
            profileSummary.personal.birthDate ?? '';
      }

      // log("Profile number: ${ProfileSummary.toJson(profileSummary)}");

      if (profileSummary.contact != null) {
        _refinancingController.phone.text =
            profileSummary.contact.cellNumber ?? '';
        _refinancingController.zipCode.text = profileSummary.contact.cep ?? '';
      }

      if (profileSummary.vehicle != null) {
        _refinancingController.licensePlate.text =
            profileSummary.vehicle.plate ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(right: 20, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.appUserSettings);
                    },
                    child: Container(
                      width: 100,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          top: Dimen.horizontal_padding,
                          bottom: Dimen.horizontal_padding),
                      margin: EdgeInsets.only(top: 40),
                      child: Image(
                        image: AssetImage("assets/images/logo.png"),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        top: Dimen.horizontal_padding,
                        bottom: Dimen.horizontal_padding),
                    margin: EdgeInsets.only(top: 60, right: 20),
                    child: AppText("REFINANCIAMENTO",
                        textColor: AppColors.grey, weight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Divider(
                  height: 2,
                  color: AppColors.grey,
                ),
              ),
              AppTextFieldSecondUI(
                label: "CPF *",
                labelColor: AppColors.dark_grey02,
                labelSize: 14,
                labelBold: FontWeight.bold,
                hint: "000.000.000-00",
                inputType: TextInputType.number,
                textEditingController: _refinancingController.itin,
              ),
              AppTextFieldSecondUI(
                label: "DATA DE NASC. *",
                labelColor: AppColors.dark_grey02,
                labelSize: 14,
                labelBold: FontWeight.bold,
                hint: "00/00/0000",
                inputType: TextInputType.number,
                textEditingController: _refinancingController.birthDate,
              ),
              AppTextFieldSecondUI(
                label: "TELEFONE *",
                labelColor: AppColors.dark_grey02,
                labelSize: 14,
                labelBold: FontWeight.bold,
                hint: "(00) 0000-0000",
                inputType: TextInputType.phone,
                textEditingController: _refinancingController.phone,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Divider(
                  height: 2,
                  color: AppColors.grey,
                ),
              ),
              AppTextFieldSecondUI(
                label: "CEP *",
                labelColor: AppColors.dark_grey02,
                labelSize: 14,
                labelBold: FontWeight.bold,
                hint: "00000-000",
                inputType: TextInputType.number,
                textEditingController: _refinancingController.zipCode,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ESTADO *',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.dark_grey02,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  shape: BoxShape.rectangle,
                  // border: new Border.all(
                  //   color: AppColors.green,
                  // ),
                  color: AppColors.light_grey02,
                ),
                child: AppStateDropdownButton.addressState(
                    onChanged: (String uf) {
                      _refinancingController.uf = uf;
                    },
                    currentItem: _refinancingController.uf,
                    enable: true,
                    isExpanded: true),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Divider(
                  height: 2,
                  color: AppColors.grey,
                ),
              ),
              AppTextFieldSecondUI(
                label: "PLACA *",
                labelColor: AppColors.dark_grey02,
                labelSize: 14,
                labelBold: FontWeight.bold,
                hint: "xxx0x00",
                inputType: TextInputType.text,
                textEditingController: _refinancingController.licensePlate,
              ),
              AppTextFieldSecondUI(
                label: "Renda mensal *",
                labelColor: AppColors.dark_grey02,
                labelSize: 14,
                labelBold: FontWeight.bold,
                hint: "R\$ 1000,00",
                inputType: TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                textEditingController: _refinancingController.monthlyIncome,
                prefix: Text("R\$ "),
              ),
              AppTextButton(
                "MINHAS SIMULAÇÕES",
                fontSize: 11,
                textColor: Colors.blue,
                onClick: () {
                  Navigator.pushNamed(context, Routes.userRequests);
                },
              ),
              if (!kReleaseMode)
                AppSaveButtonSecondUI(
                  "Preencher",
                  textWeight: FontWeight.bold,
                  textColor: AppColors.black,
                  onPressed: () async {
                    _refinancingController.fillFieldsForTest();
                  },
                ),
              AppSaveButtonSecondUI(
                "SOLICITAR SIMULAÇÃO",
                textWeight: FontWeight.bold,
                textColor: AppColors.black,
                onPressed: () async {
                  if (_refinancingController.validate() == "") {
                    showLoadingDialog(context);
                    omni.Simulation simulation =
                        _refinancingController.getSimulation();
                    _omniService.sendSimulation(simulation).then((response) {
                      Navigator.pop(context);
                      showRefinancingModal(
                          context,
                          "SEUS DADOS FORAM ENVIADOS PARA ANÁLISE!",
                          "Em até 2 horas você receberá uma notificação com o status da sua solicitação.");
                    }).catchError((err) {
                      Navigator.pop(context);
                      showMessageDialog(context,
                          message:
                              "Os serviços dos nossos parceiros estão indisponíveis no momento. "
                              "Faremos uma nova tentativa mais tarde. Caso não haja sucesso, tente novamente mais tarde.",
                          type: DialogType.ERROR);
                      print("Request error: ${err}");
                    });
                  } else {
                    showMessageDialog(context,
                        message: _refinancingController.validate(),
                        type: DialogType.ERROR);
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

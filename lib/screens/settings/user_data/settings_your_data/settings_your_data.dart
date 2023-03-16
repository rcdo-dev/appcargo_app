import 'dart:io';

import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/bank/bank.dart';
import 'package:app_cargo/domain/bank_data/bank_data.dart';
import 'package:app_cargo/domain/driver_emergency_data/driver_emergency_data.dart';
import 'package:app_cargo/domain/driver_license/driver_license.dart';
import 'package:app_cargo/domain/driver_personal_data/driver_personal_data.dart';
import 'package:app_cargo/services/me/me_service.dart';
import 'package:app_cargo/widgets/app_banks_drop_down.dart';
import 'package:app_cargo/widgets/app_dropdown_button.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/app_selectable_image.dart';
import 'package:app_cargo/widgets/app_text_field.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:app_cargo/widgets/specific/app_new_registration_dialog.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

part 'settings_your_data_controller.dart';

final bool enable = true;

class SettingsYourData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsYourDataState();
}

class _SettingsYourDataState extends State<SettingsYourData> {
  SettingsYourDataController _settingsYourDataController;
  final MeService _meService = DIContainer().get<MeService>();
  Future<DriverPersonalData> _loaded;
  String errors;

  void initState() {
    super.initState();
    _loaded = _meService.getPersonalData().then((value) {
      _settingsYourDataController = new SettingsYourDataController(value);
      showNewRegistrationInfo(context);
      return Future.delayed(Duration(milliseconds: 250), () => value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "CONFIGURAÇÕES",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: EdgeInsets.symmetric(
              vertical: Dimen.vertical_padding,
              horizontal: Dimen.horizontal_padding,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Dimen.vertical_padding,
                          horizontal: Dimen.horizontal_padding - 5,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 25,
                          color: AppColors.blue,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Dimen.horizontal_padding,
                        ),
                        child: SkyText(
                          "SEUS DADOS",
                          fontSize: 25,
                          textColor: AppColors.blue,
                        ),
                      )
                    ],
                  ),
                ),
                FutureBuilder(
                  future: _loaded,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        return Column(
                          children: <Widget>[
                            AppSelectableImage(
                              width: 120,
                              height: 160,
                              imageUrl:
                                  _settingsYourDataController.personalPhotoUrl,
                              onChange: (File file) {
                                _settingsYourDataController.personalPhoto =
                                    file;
                              },
                            ),
                            AppTextField(
                              label: "Nome ou Apelido",
                              labelColor: AppColors.blue,
                              textEditingController:
                                  _settingsYourDataController.alias,
                            ),
                            if (_settingsYourDataController.name != null &&
                                _settingsYourDataController
                                    .name.text.isNotEmpty)
                              AppTextField(
                                label: "Nome Completo",
                                labelColor: AppColors.blue,
                                textEditingController:
                                    _settingsYourDataController.name,
                                enable: enable,
                              ),
                            AppTextField(
                              label: "CPF",
                              labelColor: AppColors.blue,
                              textEditingController:
                                  _settingsYourDataController.nationalId,
                              inputType: TextInputType.number,
                              enable: enable,
                            ),
                            if (_settingsYourDataController.registry != null &&
                                _settingsYourDataController
                                    .registry.text.isNotEmpty)
                              AppTextField(
                                label: "RG",
                                labelColor: AppColors.blue,
                                textEditingController:
                                    _settingsYourDataController.registry,
                                inputType: TextInputType.text,
                                enable: enable,
                              ),
                            if (_settingsYourDataController.birthDate != null &&
                                _settingsYourDataController
                                    .birthDate.text.isNotEmpty)
                              AppTextField(
                                label: "Data de Nascimento",
                                labelColor: AppColors.blue,
                                textEditingController:
                                    _settingsYourDataController.birthDate,
                                inputType: TextInputType.numberWithOptions(
                                    decimal: false),
                                enable: enable,
                              ),
                            if (_settingsYourDataController.cnh != null &&
                                _settingsYourDataController.cnh.text.isNotEmpty)
                              AppTextField(
                                label: "CNH",
                                labelColor: AppColors.blue,
                                textEditingController:
                                    _settingsYourDataController.cnh,
                                inputType: TextInputType.number,
                                enable: enable,
                              ),
                            Row(
                              children: <Widget>[
                                if (_settingsYourDataController
                                            .driverLicenseExpirationDate !=
                                        null &&
                                    _settingsYourDataController
                                        .driverLicenseExpirationDate
                                        .text
                                        .isNotEmpty)
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: 155,
                                      padding: EdgeInsets.only(
                                        top: Dimen.vertical_padding,
                                        bottom: Dimen.vertical_padding,
                                        left: 5,
                                      ),
                                      child: AppTextField(
                                        label: "Validade CNH",
                                        labelColor: AppColors.blue,
                                        textEditingController:
                                            _settingsYourDataController
                                                .driverLicenseExpirationDate,
                                        inputType: TextInputType.number,
                                        enable: enable,
                                      ),
                                    ),
                                  ),
                                if (_settingsYourDataController
                                        .driverLicenseCategory !=
                                    null)
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.only(left: 4),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                bottom: Dimen.vertical_padding),
                                            child: SkyText(
                                              "Classificação CNH",
                                              textColor: AppColors.blue,
                                              fontSize: 17,
                                            ),
                                          ),
                                          AppDropdownButton.enumerated(
                                            DIContainer().get<
                                                DriverLicenseCategoryHelper>(),
                                            onChanged: (value) {
                                              //                                            _settingsYourDataController
                                              //                                                .driverLicenseCategory = value;
                                            },
                                            currentItem:
                                                _settingsYourDataController
                                                    .driverLicenseCategory,
                                            enable: enable,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            if (_settingsYourDataController.rntrc != null &&
                                _settingsYourDataController
                                    .rntrc.text.isNotEmpty)
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: Dimen.vertical_padding),
                                child: AppTextField(
                                  // ComboBox
                                  label: "RNTRC",
                                  hint: "Seu RNTRC",
                                  labelColor: AppColors.blue,
                                  inputType: TextInputType.numberWithOptions(
                                      decimal: false),
                                  textEditingController:
                                      _settingsYourDataController.rntrc,
                                  enable: enable,
                                ),
                              ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimen.vertical_padding),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(
                                      vertical: Dimen.vertical_padding,
                                    ),
                                    child: SkyText(
                                      "Você tem curso MOPP?",
                                      textColor: AppColors.blue,
                                      fontSize: 16,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(height: 1, width: 10),
                                  AppDropdownButton.yesOrNo(
                                    onChanged: (value) {
                                      _settingsYourDataController.hasMope =
                                          value;
                                    },
                                    currentItem:
                                        _settingsYourDataController.hasMope,
                                    enable: enable,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimen.vertical_padding),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(
                                      vertical: Dimen.vertical_padding,
                                    ),
                                    child: SkyText(
                                      "Você tem MEI?",
                                      textColor: AppColors.blue,
                                      fontSize: 16,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(height: 1, width: 10),
                                  AppDropdownButton.yesOrNo(
                                    onChanged: (value) {
                                      _settingsYourDataController.hasMEI =
                                          value;
                                    },
                                    currentItem:
                                        _settingsYourDataController.hasMEI !=
                                                null
                                            ? _settingsYourDataController.hasMEI
                                            : false,
                                    enable: enable,
                                  ),
                                ],
                              ),
                            ),
//                            Container(
//                              padding: EdgeInsets.symmetric(
//                                  vertical: Dimen.vertical_padding),
//                              child: Row(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                children: <Widget>[
//                                  Container(
//                                    alignment: Alignment.centerLeft,
//                                    padding: EdgeInsets.symmetric(
//                                      vertical: Dimen.vertical_padding,
//                                    ),
//                                    child: SkyText(
//                                      "Você é permissionado?",
//                                      textColor: AppColors.blue,
//                                      fontSize: 16,
//                                      textAlign: TextAlign.start,
//                                    ),
//                                  ),
//                                  SizedBox(height: 1, width: 10),
//                                  AppDropdownButton.yesOrNo(
//                                    onChanged: (value) {
//                                      _settingsYourDataController
//                                          .hasMercoSulPermission = value;
//                                    },
//                                    currentItem: _settingsYourDataController
//                                        .hasMercoSulPermission,
//                                    enable: enable,
//                                  ),
//                                ],
//                              ),
//                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimen.vertical_padding),
                              child: AppTextField(
                                labelColor: AppColors.blue,
                                label: "3 referências pessoais",
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: AppColors.green,
                                ),
                                textEditingController:
                                    _settingsYourDataController.reference1,
                                inputType: TextInputType.number,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimen.vertical_padding),
                              child: AppTextField(
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: AppColors.green,
                                ),
                                textEditingController:
                                    _settingsYourDataController.reference2,
                                inputType: TextInputType.number,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimen.vertical_padding),
                              child: AppTextField(
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: AppColors.green,
                                ),
                                textEditingController:
                                    _settingsYourDataController.reference3,
                                inputType: TextInputType.number,
                              ),
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Dimen.vertical_padding),
                                    child: AppTextField(
                                      labelColor: AppColors.blue,
                                      label:
                                          "3 transportadoras que ja carregou",
                                      textEditingController:
                                          _settingsYourDataController
                                              .previousFreightCompany1,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Dimen.vertical_padding),
                                    child: AppTextField(
                                      textEditingController:
                                          _settingsYourDataController
                                              .previousFreightCompany2,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Dimen.vertical_padding),
                                    child: AppTextField(
                                      textEditingController:
                                          _settingsYourDataController
                                              .previousFreightCompany3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Container(
                            //   padding: EdgeInsets.symmetric(
                            //       vertical: Dimen.vertical_padding),
                            //   child: SkyText(
                            //     "DADOS BANCARIOS",
                            //     fontSize: 25,
                            //     textColor: AppColors.blue,
                            //   ),
                            // ),
                            // AppBanksDropDown(
                            //   onChange: (Bank bank) {
                            //     _settingsYourDataController.bank = bank;
                            //   },
                            //   selectedBank: _settingsYourDataController.bank,
                            // ),
                            // Row(
                            //   children: <Widget>[
                            //     Expanded(
                            //       flex: 1,
                            //       child: Container(
                            //         padding: EdgeInsets.only(
                            //           top: Dimen.vertical_padding,
                            //           bottom: Dimen.vertical_padding,
                            //           right: 5,
                            //         ),
                            //         child: AppTextField(
                            //           label: "Agência",
                            //           labelColor: AppColors.blue,
                            //           inputType:
                            //               TextInputType.numberWithOptions(
                            //                   decimal: false),
                            //           textEditingController:
                            //               _settingsYourDataController.branch,
                            //         ),
                            //       ),
                            //     ),
                            //     Expanded(
                            //       flex: 1,
                            //       child: Container(
                            //         padding: EdgeInsets.only(
                            //           top: Dimen.vertical_padding,
                            //           bottom: Dimen.vertical_padding,
                            //           left: 5,
                            //         ),
                            //         child: AppTextField(
                            //           label: "Conta",
                            //           labelColor: AppColors.blue,
                            //           inputType:
                            //               TextInputType.numberWithOptions(
                            //                   decimal: false),
                            //           textEditingController:
                            //               _settingsYourDataController.account,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            AppSaveButton(
                              "SALVAR",
                              onPressed: () {
                                errors = _settingsYourDataController.strategy();
                                if (errors.length > 0) {
                                  showMessageDialog(context,
                                      message: errors, type: DialogType.ERROR);
                                } else {
                                  showLoadingThenOkDialog(
                                    context,
                                    _meService.updatePersonalData(
                                        _settingsYourDataController
                                            .getDriverPersonalData()),
                                  );
                                }
                              },
                            )
                          ],
                        );
                        break;
                      default:
                        return AppLoadingWidget();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

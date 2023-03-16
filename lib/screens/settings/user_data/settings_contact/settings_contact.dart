import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/address/address_api.dart';
import 'package:app_cargo/domain/driver_contact_data/driver_contact_data.dart';
import 'package:app_cargo/domain/driver_contact_update/driver_contact_update.dart';
import 'package:app_cargo/domain/driver_emergency_data/driver_emergency_data.dart';
import 'package:app_cargo/domain/driver_social_data/driver_social_data.dart';
import 'package:app_cargo/domain/state/state.dart';
import 'package:app_cargo/domain/city/city.dart';
import 'package:app_cargo/services/me/me_service.dart';
import 'package:app_cargo/services/util/util_service.dart';
import 'package:app_cargo/widgets/app_city_state_dropdown.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../../../routes.dart';

part 'settings_contact_controller.dart';

class SettingsContactData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsContactDataState();
}

class _SettingsContactDataState extends State<SettingsContactData> {
  final MeService _meService = DIContainer().get<MeService>();
  final UtilService _utilService = DIContainer().get<UtilService>();
  Future<DriverContactUpdate> _loaded;
  SettingsContactDataController settingsContactDataController;
  Widget _stateWidget;

  void initState() {
    super.initState();
    _loaded = _meService.getContactUpdateData().then((value) {
      settingsContactDataController = new SettingsContactDataController(value);
      _buildStateWidget();
      return Future.delayed(Duration(milliseconds: 250), () => value);
    }).catchError((error) {
      print(error);
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
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: AppColors.white,
            ),
            padding: EdgeInsets.symmetric(
                vertical: Dimen.horizontal_padding,
                horizontal: Dimen.horizontal_padding),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimen.vertical_padding,
                            horizontal: Dimen.horizontal_padding - 5),
                        child: Icon(
                          Icons.perm_contact_calendar,
                          size: 25,
                          color: AppColors.blue,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimen.vertical_padding,
                            horizontal: Dimen.horizontal_padding - 5),
                        child: SkyText(
                          "DADOS DE CONTATO",
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
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimen.vertical_padding),
                              child: AppTextField(
                                label: "CEP",
                                labelColor: AppColors.blue,
                                textEditingController:
                                    settingsContactDataController
                                        .contactCepController,
                                inputType: TextInputType.number,
                                onChanged: (String cep) {
                                  if (cep.length == 9)
                                    _getAddressApiAndFillFields(cep);
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimen.vertical_padding),
                              child: AppTextField(
                                label: "Endereço",
                                labelColor: AppColors.blue,
                                textEditingController:
                                    settingsContactDataController
                                        .contactStreetController,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimen.vertical_padding),
                              child: AppTextField(
                                label: "Numero",
                                labelColor: AppColors.blue,
                                textEditingController:
                                    settingsContactDataController
                                        .contactNumberController,
                                inputType: TextInputType.number,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimen.vertical_padding),
                              child: AppTextField(
                                label: "Bairro",
                                labelColor: AppColors.blue,
                                textEditingController:
                                    settingsContactDataController
                                        .contactNeighborhoodController,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimen.vertical_padding),
                              child: _stateWidget,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: Dimen.vertical_padding,
                                  bottom: Dimen.vertical_padding + 15),
                              child: AppTextField(
                                label: "Celular",
                                labelColor: AppColors.blue,
                                textEditingController:
                                    settingsContactDataController
                                        .contactCellNumberController,
                                inputType: TextInputType.number,
                              ),
                            ),
                            Container(
                              width: 300,
                              height: 1,
                              color: AppColors.yellow,
                            ),
                            Container(
                                padding: EdgeInsets.only(
                                    top: Dimen.vertical_padding + 15,
                                    bottom: Dimen.vertical_padding),
                                child: SkyText("CONTATO DE EMERGENCIA",
                                    fontSize: 23, textColor: AppColors.blue)),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimen.vertical_padding),
                              child: AppTextField(
                                label: "Nome",
                                labelColor: AppColors.blue,
                                textEditingController:
                                    settingsContactDataController
                                        .emergencyNameController,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimen.vertical_padding),
                              child: AppTextField(
                                label: "Parentesco",
                                labelColor: AppColors.blue,
                                textEditingController:
                                    settingsContactDataController
                                        .emergencyRelationController,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: Dimen.vertical_padding,
                                  bottom: Dimen.vertical_padding + 15),
                              child: AppTextField(
                                label: "Telefone/Celular",
                                labelColor: AppColors.blue,
                                inputType: TextInputType.number,
                                textEditingController:
                                    settingsContactDataController
                                        .emergencyNumberController,
                              ),
                            ),
                            Container(
                              width: 300,
                              height: 1,
                              color: AppColors.yellow,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: Dimen.vertical_padding + 15,
                                  bottom: Dimen.vertical_padding),
                              child: SkyText("SOCIAL",
                                  fontSize: 23, textColor: AppColors.blue),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimen.vertical_padding),
                              child: AppTextField(
                                label: "Facebook",
                                labelColor: AppColors.blue,
                                textEditingController:
                                    settingsContactDataController
                                        .socialFacebookController,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimen.vertical_padding),
                              child: AppTextField(
                                  label: "Instagram",
                                  labelColor: AppColors.blue,
                                  textEditingController:
                                      settingsContactDataController
                                          .socialInstagramController),
                            ),
                            AppSaveButton(
                              "SALVAR",
                              onPressed: () {
                                print(DriverContactUpdate.toJson(
                                    settingsContactDataController
                                        .getDriverContactUpdate(
                                            driverContactDataValidation(),
                                            driverEmergencyDataValidation(),
                                            driverSocialDataValidation())));
                                showLoadingThenOkDialog(
                                  context,
                                  _meService.updateContactData(
                                    settingsContactDataController
                                        .getDriverContactUpdate(
                                            driverContactDataValidation(),
                                            driverEmergencyDataValidation(),
                                            driverSocialDataValidation()),
                                  ),
                                );
                              },
                            ),
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

  void _getAddressApiAndFillFields(String cep) {
    showLoadingThenOkDialog(context, _utilService.getAddressFromCep(cep))
        .then((addressApi) {
      if (addressApi is AddressApi) {
        setState(() {
          this
              .settingsContactDataController
              .fillControllersWithNewAddressApi(addressApi);
          _buildStateWidget();
        });
      }
    });
  }

  void _buildStateWidget() {
    // TODO change AppCityStateDropdown state management to Provider
    // TEMPORARY SOLUTION, this is a bad solution, but for now it's working.

    // Flutter was not rebuilding the AppCityStateDropdown widget when we were creating a new instance with "new"
    // so using this solution we're forcing the widget to rebuild

    _stateWidget = Container();

    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        _stateWidget = new AppCityStateDropdown(
          defaultState:
              this.settingsContactDataController.contactStateAcronymController,
          defaultCity: this.settingsContactDataController.contactCityController,
          onStateChanged: (String stateAcronym) {
            this.settingsContactDataController.contactStateAcronymController =
                stateAcronym;
          },
          onCityChanged: (City city) {
            this.settingsContactDataController.contactCityController = city;
          },
        );
      });
    });
  }

  DriverContactData driverContactDataValidation() {
    if (settingsContactDataController.contactCepController.text != "" &&
        settingsContactDataController.contactNumberController.text != "") {
      return settingsContactDataController.getDriverContactData();
    }

    return null;
  }

  DriverEmergencyData driverEmergencyDataValidation() {
    if (settingsContactDataController.emergencyNameController.text != "" &&
        settingsContactDataController.emergencyNumberController.text != "" &&
        settingsContactDataController.emergencyRelationController.text != "") {
      return settingsContactDataController.getDriverEmergencyData();
    }

    return null;
  }

  DriverSocialData driverSocialDataValidation() {
    if (settingsContactDataController.socialFacebookController.text != "" ||
        settingsContactDataController.socialInstagramController.text != "") {
      return settingsContactDataController.getDriverSocialData();
    }

    return null;
  }
}

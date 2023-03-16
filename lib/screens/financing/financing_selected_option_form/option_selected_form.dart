import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/city/city.dart';
import 'package:app_cargo/domain/omni/civil_states/omni_civil_states.dart';
import 'package:app_cargo/domain/omni/professional_classes/omni_professional_class.dart';
import 'package:app_cargo/domain/omni/professions/omni_profession.dart';
import 'package:app_cargo/screens/financing/financing_selected_option_form/option_financing_selected_form_controller.dart';
import 'package:app_cargo/screens/financing/widgets/app_financing_custom_text_field.dart';
import 'package:app_cargo/screens/financing/widgets/app_form_city_state_dropdown.dart';
import 'package:app_cargo/screens/financing/widgets/app_form_label.dart';
import 'package:app_cargo/screens/financing/widgets/app_state_dropdown_button.dart';
import 'package:app_cargo/screens/financing/widgets/refinancing_modal.dart';
import 'package:app_cargo/services/omni/omni_service.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/app_save_button_second_ui.dart';
import 'package:app_cargo/widgets/app_text.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OptionSelectedForm extends StatefulWidget {
  const OptionSelectedForm({Key key}) : super(key: key);

  @override
  _OptionSelectedFormState createState() => _OptionSelectedFormState();
}

class _OptionSelectedFormState extends State<OptionSelectedForm> {
  OmniService _omniService = DIContainer().get<OmniService>();

  List<OmniProfession> _professionsList = List<OmniProfession>();
  List<OmniCivilStates> _civilStateList = List<OmniCivilStates>();
  List<OmniProfessionalClass> _professionalClassesList =
      List<OmniProfessionalClass>();

  OptionFinancingSelectedFormController _formController;

  String simulationFriendlyHash;
  String refinancingOptionFriendlyHash;
  int refinancingOptionNumber;

  Future _loaded;

  @override
  void initState() {
    super.initState();

    _loaded = _omniService.getProfessions().then((professions) {
      return _omniService.getProfessionalClasses().then((professionalClasses) {
        return _omniService.getCivilStates().then((civilStates) {
          setState(() {
            _professionalClassesList.addAll(professionalClasses);
            _professionsList.addAll(professions);
            _civilStateList.addAll(civilStates);
          });
        });
      });
    });
    // _buildStateWidget();
    _formController = new OptionFinancingSelectedFormController();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    if (args != null && args.isNotEmpty) {
      simulationFriendlyHash = args["proposal_friendly_hash"] as String;
      refinancingOptionFriendlyHash =
          args["refinancing_option_friendly_hash"] as String;
      refinancingOptionNumber = args["refinancing_option_number"] as int;
    }

    Comparator<OmniProfessionalClass> sortById =
        (a, b) => a.professionalClassId.compareTo(b.professionalClassId);
    _professionalClassesList.sort(sortById);
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 80),
                alignment: Alignment.topLeft,
                child: AppText(
                  "VOCÊ ESCOLHEU A OPÇÃO $refinancingOptionNumber",
                  fontSize: 15,
                  weight: FontWeight.bold,
                  textColor: AppColors.light_green,
                ),
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(height: 25),
              FutureBuilder(
                future: _loaded,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      return _professionsList.isEmpty ||
                              _professionalClassesList.isEmpty ||
                              _civilStateList.isEmpty
                          ? Container(
                              child: Text(
                                "Os serviços do nosso parceiro estão indisponíveis no momento. Tente novamente mais tarde!",
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Column(
                              children: <Widget>[
                                AppText(
                                  "Para continuar, preencha os dados abaixo",
                                  fontSize: 14,
                                  weight: FontWeight.bold,
                                  textColor: Colors.grey[600],
                                ),
                                SizedBox(height: 20),
                                AppFormLabel(
                                  labelText: "Informações pessoais",
                                ),
                                AppFinancingCustomTextField(
                                  "NOME COMPLETO:",
                                  controller:
                                      _formController.driverNameController,
                                ),
                                AppFinancingCustomTextField(
                                  "NOME DA MÃE:",
                                  controller:
                                      _formController.motherNameController,
                                ),
                                AppFinancingCustomTextField(
                                  "NOME DO PAI:",
                                  controller:
                                      _formController.fatherNameController,
                                ),
                                AppFinancingCustomTextField(
                                  "RG:",
                                  controller: _formController
                                      .driverNationalIDController,
                                ),
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      flex: 5,
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: AppFinancingCustomTextField(
                                          "DATA DE EXPEDIÇÃO:",
                                          controller: _formController
                                              .driverNationalIDShippingDateController,
                                          textInputType: TextInputType.datetime,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 4,
                                      child: Container(
                                        // margin: EdgeInsets.only(left: 5),
                                        child: AppFinancingCustomTextField(
                                          "ORGÃO EXPEDIDOR:",
                                          controller: _formController
                                              .driverNationalIDIssuingBodyController,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                AppFinancingCustomTextField(
                                  "NACIONALIDADE:",
                                  controller: _formController
                                      .driverCountryNationalityController,
                                ),
                                AppFormLabel(
                                  labelText: "Natural de",
                                ),
                                Container(
                                  child: AppFormCityStateDropdown(
                                    defaultState: "SP",
                                    defaultCity: new City(name: "São Paulo"),
                                    onStateChanged: (String stateAcronym) {
                                      _formController
                                              .driverNaturalnessFromState =
                                          stateAcronym;
                                    },
                                    onCityChanged: (City city) {
                                      _formController
                                              .driverNaturalnessFromCity =
                                          city.name;
                                    },
                                  ),
                                ),
                                Container(
                                  height: 45,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.light_grey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: AppStateDropdownButton(
                                    items: OmniCivilStates
                                        .mapToBuildCivilStateDropdown(
                                            _civilStateList),
                                    onChanged: (String state) {
                                      for (OmniCivilStates civilState
                                          in _civilStateList) {
                                        if (civilState.description == state) {
                                          _formController.driverCivilState =
                                              civilState.civilStateId;
                                        }
                                      }
                                    },
                                    currentItem: "Selecione um estado civil",
                                    enable: true,
                                    isExpanded: true,
                                  ),
                                ),
                                AppFinancingCustomTextField(
                                  "TELEFONE:",
                                  controller: _formController
                                      .driverPhoneNumberController,
                                  textInputType: TextInputType.number,
                                ),
                                AppFormLabel(
                                  labelText: "Valor do patrimônio em R\$",
                                ),
                                AppFinancingCustomTextField(
                                  "VALOR DO PATRIMÔNIO EM R\$:",
                                  controller:
                                      _formController.patrimonyValueController,
                                  textInputType:
                                      TextInputType.numberWithOptions(
                                          decimal: true),
                                ),
                                AppFormLabel(
                                  labelText: "Endereço",
                                ),
                                AppFinancingCustomTextField("CEP:",
                                    controller:
                                        _formController.zipCodeController,
                                    textInputType: TextInputType.number,
                                    onChanged: _formController.getUserAddress),
                                AppFinancingCustomTextField(
                                  "LOGRADOURO:",
                                  controller: _formController.placeController,
                                ),
                                AppFinancingCustomTextField(
                                  "NÚMERO RESIDÊNCIA:",
                                  controller:
                                      _formController.residenceNumberController,
                                  textInputType: TextInputType.number,
                                ),
                                AppFinancingCustomTextField(
                                  "COMPLEMENTO:",
                                  controller: _formController
                                      .residenceComplementController,
                                ),
                                AppFinancingCustomTextField(
                                  "BAIRRO:",
                                  controller:
                                      _formController.districtController,
                                ),
                                AppFormLabel(
                                  labelText: "Estado e cidade da residência",
                                ),
                                Container(
                                  child: AppFormCityStateDropdown(
                                    defaultState: "SP",
                                    defaultCity: new City(name: "São Paulo"),
                                    onStateChanged: (String stateAcronym) {
                                      _formController.stateController =
                                          stateAcronym;
                                    },
                                    onCityChanged: (City city) {
                                      _formController.cityController =
                                          city.name;
                                    },
                                  ),
                                ),
                                AppFormLabel(
                                  labelText: "Informações profissionais",
                                ),
                                Container(
                                  height: 45,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.light_grey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: AppStateDropdownButton(
                                    items: OmniProfessionalClass
                                        .mapToBuildProfessionsClassesDropdown(
                                            _professionalClassesList),
                                    onChanged: (String selectedClass) {
                                      for (OmniProfessionalClass pClass
                                          in _professionalClassesList) {
                                        if (pClass.description ==
                                            selectedClass) {
                                          _formController
                                                  .driverProfessionalClassController =
                                              pClass.professionalClassId;
                                        }
                                      }
                                    },
                                    currentItem:
                                        "Selecione uma classe profissional",
                                    enable: true,
                                    isExpanded: true,
                                  ),
                                ),
                                Container(
                                  height: 45,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.light_grey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: AppStateDropdownButton(
                                    items: OmniProfession
                                        .mapToBuildProfessionsClassesDropdown(
                                            _professionsList),
                                    onChanged: (String selectedProfession) {
                                      for (OmniProfession profession
                                          in _professionsList) {
                                        if (profession.description ==
                                            selectedProfession) {
                                          _formController
                                                  .driverProfessionalTypeController =
                                              profession.professionId;
                                        }
                                      }
                                    },
                                    currentItem: "Selecione uma profissão",
                                    enable: true,
                                    isExpanded: true,
                                  ),
                                ),
                                AppFinancingCustomTextField(
                                  "NOME DA EMPRESA:",
                                  controller:
                                      _formController.companyNameController,
                                ),
                                AppFinancingCustomTextField(
                                  "TELEFONE DA EMPRESA:",
                                  controller: _formController
                                      .companyPhoneNumberController,
                                  textInputType: TextInputType.number,
                                ),
                                AppFinancingCustomTextField(
                                  "CEP DA EMPRESA:",
                                  controller:
                                      _formController.companyAddresZipCode,
                                  onChanged: _formController.getCompanyAddress,
                                  textInputType: TextInputType.number,
                                ),
                                AppFinancingCustomTextField(
                                  "LOGRADOURO DA EMPRESA:",
                                  controller: _formController
                                      .companyAddressPlaceController,
                                ),
                                AppFinancingCustomTextField(
                                  "BAIRRO DA EMPRESA:",
                                  controller: _formController
                                      .companyAddressDistrictController,
                                ),
                                AppFinancingCustomTextField(
                                  "NUM. DA EMPRESA:",
                                  controller: _formController
                                      .companyAddressNumberController,
                                  textInputType: TextInputType.number,
                                ),
                                AppFinancingCustomTextField(
                                  "COMPLEMENTO DA EMPRESA:",
                                  controller: _formController
                                      .companyAddressComplementController,
                                ),
                                AppFormLabel(
                                  labelText: "Estado e cidade da empresa",
                                ),
                                Container(
                                  child: AppFormCityStateDropdown(
                                    defaultState: "SP",
                                    defaultCity: new City(name: "São Paulo"),
                                    onStateChanged: (String stateAcronym) {
                                      _formController
                                              .companyAddressUFController =
                                          stateAcronym;
                                    },
                                    onCityChanged: (City city) {
                                      _formController
                                              .companyAddressCityController =
                                          city.name;
                                    },
                                  ),
                                ),
                                AppFinancingCustomTextField(
                                  "OBSERVAÇÕES",
                                  textInputType: TextInputType.multiline,
                                  controller: _formController.notesController,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                if (!kReleaseMode)
                                  AppSaveButtonSecondUI(
                                    "Preencher",
                                    textWeight: FontWeight.bold,
                                    textColor: AppColors.black,
                                    onPressed: () async {
                                      _formController.fillTextFieldForTest();
                                    },
                                  ),
                                AppSaveButtonSecondUI(
                                  "ENVIAR",
                                  textWeight: FontWeight.bold,
                                  textColor: AppColors.black,
                                  onPressed: () async {
                                    //TODO: REFACTOR ERROR TREATMENT
                                    if (_formController.validate() == "") {
                                      showLoadingDialog(context);

                                      _omniService
                                          .sendFinancingProposal(
                                              _formController.getFinancingProposal(
                                                  refinancingOptionFriendlyHash),
                                              simulationFriendlyHash)
                                          .then((response) {
                                        Navigator.pop(context);
                                        showRefinancingModal(
                                            context,
                                            "A opção escolhida será avaliada pelo banco!"
                                                .toUpperCase(),
                                            "Em até 2 dias você receberá uma notificação com o status da sua solicitação.");
                                      });
                                    } else {
                                      showMessageDialog(context,
                                          message: _formController.validate(),
                                          type: DialogType.ERROR);
                                    }
                                  },
                                ),
                              ],
                            );

                    default:
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AppLoadingWidget(),
                        ],
                      );
                  }
                },
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

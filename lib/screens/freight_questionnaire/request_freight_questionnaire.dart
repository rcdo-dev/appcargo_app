import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/city/city.dart';
import 'package:app_cargo/domain/profile_summary/profile_summary.dart';
import 'package:app_cargo/domain/truck/truck.dart';
import 'package:app_cargo/screens/freight_questionnaire/request_freight_questionnaire_controller.dart';
import 'package:app_cargo/screens/freight_questionnaire/request_freight_questionnaire_last_screen.dart';
import 'package:app_cargo/screens/freight_questionnaire/widgets/app_truck_select_freight_questionnaire.dart';
import 'package:app_cargo/services/me/me_service.dart';
import 'package:app_cargo/services/request_freight_questionnaire_service/request_freight_questionnaire_service.dart';
import 'package:app_cargo/widgets/app_city_state_dropdown.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/app_radio_button.dart';
import 'package:app_cargo/widgets/app_text.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RequestFreightQuestionnaire extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<RequestFreightQuestionnaire> {
  bool showFirstQuestionnaire = true;
  bool showFinishQuestionnaire = false;
  bool sendQuestionnaire = false;
  Future _loadedVehicleData;
  MeService _meService = DIContainer().get<MeService>();

  Widget vehicleShowNegativeOption = Container();
  Widget localizationShowNegativeOption = Container();

  RequestFreightQuestionnaireService _requestFreightQuestionnaireService =
      DIContainer().get<RequestFreightQuestionnaireService>();

  List<String> localizationRadioButtonOptions;
  List<String> vehicleRadioButtonOptions = ["SIM", "NÃO"];

  RequestFreightQuestionnaireController requestFreightController;

  Map<String, dynamic> addressData;
  ProfileSummary profileSummary;

  double kgCapacity = 0;
  bool isUtilitario;
  bool isOpenTruckTrailer = true;

  bool _anyDestination = false;

  void _checkBoxAnyDestination(bool flag) {
    setState(() {
      _anyDestination = flag;
    });
  }

  @override
  void initState() {
    super.initState();
    requestFreightController = new RequestFreightQuestionnaireController();
    this.requestFreightController.weightCapacity = 0;
    this.requestFreightController.trailerType = TrailerType.ABERTO;

    _loadedVehicleData = _meService.getAllDriverData().then((profileSummary) {
      setState(() {
        this.profileSummary = profileSummary;
        isUtilitario =
            this.profileSummary.vehicle.truckType == TruckType.UTILITARIO;
        this.requestFreightController.truckType =
            this.profileSummary.vehicle.truckType;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool destination = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Solicitar Fretes",
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15),
              child: FutureBuilder(
                future: _loadedVehicleData,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AppText(
                            "Oiiii, ${this.profileSummary.personal.alias}! Vamos encontrar o melhor frete para você.\nConfirme as seguintes perguntas...",
                            fontSize: 20,
                            textColor: AppColors.black,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: showFinishQuestionnaire ? 1 : 0.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.green,
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          showFirstQuestionnaire
                              ? buildFirstQuestion()
                              : !showFirstQuestionnaire
                                  ? buildSecondQuestionDestination()
                                  : SizedBox(),
                        ],
                      );
                      break;
                    default:
                      return AppLoadingWidget();
                      break;
                  }
                },
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: CheckboxListTile(
                    activeColor: AppColors.green,
                    checkColor: AppColors.white,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      'Qualquer destino',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    value: _anyDestination,
                    onChanged: _checkBoxAnyDestination,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: FloatingActionButton.extended(
                      onPressed: _loadedVehicleData != null
                          ? () {
                              setState(() {
                                if (!showFirstQuestionnaire) {
                                  if (!sendQuestionnaire) {
                                    this
                                        .requestFreightController
                                        .weightCapacity = kgCapacity.round();

                                    if (_anyDestination) {
                                      if (this.requestFreightController.city !=
                                          null) {
                                        _requestFreightQuestionnaireService
                                            .sendQuestionnaireData(
                                          requestFreightController
                                              .getQuestionnaireData(),
                                        );

                                        sendQuestionnaire = true;
                                        showFinishQuestionnaire = true;
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RequestFreightQuetionaireLastScreen(),
                                          ),
                                        );
                                      } else {
                                        showMessageDialog(
                                          context,
                                          message:
                                              "Cidade não selecionada.\nÉ necessário que clique em uma cidade da lista",
                                          type: DialogType.ERROR,
                                        );
                                      }
                                    } else {
                                      if (this.requestFreightController.city !=
                                              null &&
                                          this
                                                  .requestFreightController
                                                  .destinationCity !=
                                              null) {
                                        _requestFreightQuestionnaireService
                                            .sendQuestionnaireData(
                                          requestFreightController
                                              .getQuestionnaireDataPremium(),
                                        );

                                        sendQuestionnaire = true;
                                        showFinishQuestionnaire = true;
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RequestFreightQuetionaireLastScreen(),
                                          ),
                                        );
                                      } else {
                                        showMessageDialog(
                                          context,
                                          message:
                                              "Cidade não selecionada.\nÉ necessário que clique em uma cidade da lista",
                                          type: DialogType.ERROR,
                                        );
                                      }
                                    }
                                  } else {
                                    Navigator.pop(context);
                                  }
                                } else {
                                  showFirstQuestionnaire = false;
                                }
                              });
                            }
                          : null,
                      label: Row(
                        children: <Widget>[
                          Text("Próxima"),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFirstQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: AppText(
            "Pergunta 1",
            fontSize: 20,
            textColor: AppColors.grey,
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: AppText(
            "Seu veículo é um ${this.profileSummary.vehicle.truckType.name()}?",
            fontSize: 18,
            textColor: AppColors.black,
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        new AppRadioButton(
            key: Key('vehicle'),
            radioOptions: vehicleRadioButtonOptions,
            selectedOptionCallback: (val) {
              setState(() {
                isUtilitario = this.profileSummary.vehicle.truckType ==
                    TruckType.UTILITARIO;

                if (val == vehicleRadioButtonOptions[1]) {
                  vehicleShowNegativeOption = buildNegativeOption();

                  isUtilitario = false;
                } else {
                  vehicleShowNegativeOption = Container();
                }
              });
            }),
        SizedBox(height: 20),
        vehicleShowNegativeOption,
        isUtilitario
            ? Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("A carroceria do seu veículo é:"),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                requestFreightController.trailerType =
                                    TrailerType.ABERTO;
                                isOpenTruckTrailer = true;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 85,
                              width: 130,
                              decoration: BoxDecoration(
                                  color: isOpenTruckTrailer
                                      ? AppColors.green
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/ic_open_truck_trailer.png",
                                    height: 40,
                                    color: isOpenTruckTrailer
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                  Text(
                                    "Aberta".toUpperCase(),
                                    style: TextStyle(
                                        color: isOpenTruckTrailer
                                            ? AppColors.white
                                            : AppColors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                requestFreightController.trailerType =
                                    TrailerType.FECHADO;
                                isOpenTruckTrailer = false;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 85,
                              width: 130,
                              decoration: BoxDecoration(
                                color: isOpenTruckTrailer
                                    ? Colors.grey[300]
                                    : AppColors.green,
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/ic_close_truck_trailer.png",
                                    height: 40,
                                    color: isOpenTruckTrailer
                                        ? AppColors.black
                                        : AppColors.white,
                                  ),
                                  Text(
                                    "Fechada".toUpperCase(),
                                    style: TextStyle(
                                        color: isOpenTruckTrailer
                                            ? AppColors.black
                                            : AppColors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
        SizedBox(height: 20),
        isUtilitario
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Capacidade de carga (KG): ${kgCapacity.floor()}",
                    ),
                  ),
                  Slider(
                    value: kgCapacity,
                    activeColor: AppColors.green,
                    max: 2000,
                    onChanged: (val) {
                      setState(() {
                        kgCapacity = val;
                      });
                    },
                  ),
                ],
              )
            : Container()
      ],
    );
  }

  Widget buildNegativeOption() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppText(
          "Ah! Então, me fala qual é seu veículo",
          fontSize: 18,
          textColor: AppColors.black,
          textAlign: TextAlign.left,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.only(bottom: 30),
          child: AppTruckSelectFreightQuestionnaire(
            onChanged: (truckType) {
              setState(() {
                if (truckType == TruckType.UTILITARIO) {
                  isUtilitario = true;
                } else {
                  isUtilitario = false;
                }
              });

              requestFreightController.truckType = truckType;
            },
            defaultValue: TruckType.UTILITARIO,
          ),
        )
      ],
    );
  }

  Widget buildSecondQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.symmetric(vertical: 20),
          child: AppText(
            "Pergunta 2",
            fontSize: 20,
            textColor: AppColors.grey,
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: AppText(
            "Informe sua localização:",
            fontSize: 18,
            textColor: AppColors.black,
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: AppCityStateDropdown(
                defaultState: this.requestFreightController.uf,
                defaultCity: this.requestFreightController.city,
                onStateChanged: (String stateAcronym) {
                  this.requestFreightController.uf = stateAcronym;

                  if (this.requestFreightController.lastUF != stateAcronym) {
                    setState(() {
                      this.requestFreightController.city = null;
                      this.requestFreightController.lastUF =
                          this.requestFreightController.uf;
                    });
                  }
                },
                onCityChanged: (City city) {
                  setState(() {
                    this.requestFreightController.city = city;
                  });
                },

                /// O elemento enviado da classe filho é
                /// atribuído ao fluxo de continuidade do código.
                checkText: (value) {
                  this.requestFreightController.city = value;
                },
              ),
            )
          ],
        ),
        SizedBox(height: 20),
        localizationShowNegativeOption,
      ],
    );
  }

  Widget buildSecondQuestionDestination() {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.symmetric(vertical: 20),
          child: AppText(
            "Pergunta 2",
            fontSize: 20,
            textColor: AppColors.grey,
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: AppText(
            "Informe sua localização:",
            fontSize: 18,
            textColor: AppColors.black,
            textAlign: TextAlign.start,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: AppCityStateDropdown(
                defaultState: this.requestFreightController.uf,
                defaultCity: this.requestFreightController.city,
                onStateChanged: (String stateAcronym) {
                  this.requestFreightController.uf = stateAcronym;

                  if (this.requestFreightController.lastUF != stateAcronym) {
                    setState(() {
                      this.requestFreightController.city = null;
                      this.requestFreightController.lastUF =
                          this.requestFreightController.uf;
                    });
                  }
                },
                onCityChanged: (City city) {
                  setState(() {
                    this.requestFreightController.city = city;
                  });
                },

                /// O elemento enviado da classe filho é
                /// atribuído ao fluxo de continuidade do código.
                checkText: (value) {
                  this.requestFreightController.city = value;
                },
              ),
            )
          ],
        ),
        !_anyDestination
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: AppText(
                      "Informe o seu destino:",
                      fontSize: 18,
                      textColor: AppColors.black,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: AppCityStateDropdown(
                      defaultState: this.requestFreightController.uf,

                      defaultCity:
                          this.requestFreightController.destinationCity,
                      onStateChanged: (String stateAcronym) {
                        this.requestFreightController.uf = stateAcronym;

                        if (this.requestFreightController.lastUF !=
                            stateAcronym) {
                          setState(() {
                            this.requestFreightController.destinationCity =
                                null;
                            this.requestFreightController.lastUF =
                                this.requestFreightController.uf;
                          });
                        }
                      },
                      onCityChanged: (City city) {
                        setState(() {
                          this.requestFreightController.destinationCity = city;
                        });
                      },

                      /// O elemento enviado da classe filho é
                      /// atribuído ao fluxo de continuidade do código.
                      checkText: (value) {
                        this.requestFreightController.destinationCity = value;
                      },
                    ),
                  )
                ],
              )
            : SizedBox(
                height: size.height / 5.4, //163,
              ),
        SizedBox(
          height: 20,
        ),
        localizationShowNegativeOption,
      ],
    );
  }
}

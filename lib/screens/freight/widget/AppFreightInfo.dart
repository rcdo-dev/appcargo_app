import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/chat/chat_member.dart';
import 'package:app_cargo/domain/freight_details/freight_details.dart';
import 'package:app_cargo/domain/lat_lng/lat_lng.dart';
import 'package:app_cargo/domain/util/map_utils.dart';
import 'package:app_cargo/domain/util/number_formatters.dart';
import 'package:app_cargo/http/api_error.dart';
import 'package:app_cargo/services/freight/freight_service.dart';
import 'package:app_cargo/services/freight_company/freight_company_service.dart';
import 'package:app_cargo/widgets/app_action_button.dart';
import 'package:app_cargo/widgets/app_confirm_popup.dart';
import 'package:app_cargo/widgets/app_horizontal_divider.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../../routes.dart';

class AppFreightInfo extends StatefulWidget {
  final FreightDetails freightDetails;
  final bool proposal;

  const AppFreightInfo(this.freightDetails, {Key key, this.proposal})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _AppFreightInfoState(freightDetails, proposal);
}

class _AppFreightInfoState extends State<AppFreightInfo> {
  final FreightService _freightService = DIContainer().get<FreightService>();
  final FreightCompanyService _freightCompanyService =
      DIContainer().get<FreightCompanyService>();
  final FreightDetails freightDetails;

  String distance;
  String weight;
  String amount;
  String toll;
  String termDays;

  Widget _openMapButtonCompany;
  Widget _openMapButtonFreightOrigin;
  Widget _openMapButtonFreightDestiny;

  final bool proposal;

  _AppFreightInfoState(this.freightDetails, this.proposal);

  @override
  void initState() {
    super.initState();
    _buildBeautifulValues();
    _buildMapButtons();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: freightDetails.code,
      body: Column(
        children: <Widget>[
          Container(
            child: Container(
              decoration: new BoxDecoration(
                  color: AppColors.white,
                  borderRadius: new BorderRadius.all(Radius.circular(10))),
              padding: EdgeInsets.symmetric(
                  horizontal: Dimen.horizontal_padding,
                  vertical: Dimen.vertical_padding),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: AppColors.blue),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: Image.network(
                        freightDetails.freightCompany.photo,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimen.vertical_padding),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    top: Dimen.vertical_padding,
                                    bottom: Dimen.vertical_padding,
                                    right: Dimen.horizontal_padding),
                                child: SkyText(
                                  "Origem",
                                  textColor: AppColors.blue,
                                  fontSize: 20,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: Dimen.vertical_padding,
                                    bottom: Dimen.vertical_padding,
                                    right: Dimen.horizontal_padding),
                                child: SkyText(
                                  "Destino",
                                  textColor: AppColors.blue,
                                  fontSize: 20,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: Dimen.vertical_padding,
                                    bottom: Dimen.vertical_padding,
                                    right: Dimen.horizontal_padding),
                                child: SkyText(
                                  "Distância",
                                  textColor: AppColors.blue,
                                  fontSize: 20,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: Dimen.vertical_padding,
                                    bottom: Dimen.vertical_padding,
                                    right: Dimen.horizontal_padding),
                                child: SkyText(
                                  "Kilo",
                                  textColor: AppColors.blue,
                                  fontSize: 20,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: Dimen.vertical_padding,
                                    bottom: Dimen.vertical_padding,
                                    right: Dimen.horizontal_padding),
                                child: SkyText(
                                  "Valor",
                                  textColor: AppColors.blue,
                                  fontSize: 20,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: Dimen.vertical_padding,
                                    bottom: Dimen.vertical_padding,
                                    right: Dimen.horizontal_padding),
                                child: SkyText(
                                  "Pedagio",
                                  textColor: AppColors.blue,
                                  fontSize: 20,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: Dimen.vertical_padding,
                                    bottom: Dimen.vertical_padding,
                                    right: Dimen.horizontal_padding),
                                child: SkyText(
                                  "Prazo",
                                  textColor: AppColors.blue,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),

                          // ============================================================= \\

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    top: Dimen.vertical_padding,
                                    bottom: Dimen.vertical_padding,
                                    right: Dimen.horizontal_padding),
                                child: SkyText(
                                  freightDetails.from.cityName +
                                      "/" +
                                      freightDetails.from.stateAcronym,
                                  textColor: AppColors.green,
                                  fontSize: 20,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: Dimen.vertical_padding,
                                    bottom: Dimen.vertical_padding,
                                    right: Dimen.horizontal_padding),
                                child: SkyText(
                                  freightDetails.to.cityName +
                                      "/" +
                                      freightDetails.to.stateAcronym,
                                  textColor: AppColors.green,
                                  fontSize: 20,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: Dimen.vertical_padding,
                                    bottom: Dimen.vertical_padding,
                                    right: Dimen.horizontal_padding),
                                child: SkyText(
                                  distance,
                                  textColor: AppColors.green,
                                  fontSize: 20,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: Dimen.vertical_padding,
                                    bottom: Dimen.vertical_padding,
                                    right: Dimen.horizontal_padding),
                                child: SkyText(
                                  weight,
                                  textColor: AppColors.green,
                                  fontSize: 20,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: Dimen.vertical_padding,
                                    bottom: Dimen.vertical_padding,
                                    right: Dimen.horizontal_padding),
                                child: SkyText(
                                  amount,
                                  textColor: AppColors.green,
                                  fontSize: 20,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: Dimen.vertical_padding,
                                    bottom: Dimen.vertical_padding,
                                    right: Dimen.horizontal_padding),
                                child: SkyText(
                                  // TODO: here we need to convert this value to double and then display the amount of the tool
                                  toll,
                                  textColor: AppColors.green,
                                  fontSize: 20,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: Dimen.vertical_padding,
                                    bottom: Dimen.vertical_padding,
                                    right: Dimen.horizontal_padding),
                                child: SkyText(
                                  termDays,
                                  textColor: AppColors.green,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: SkyText(
                        "Forma de Pagamento",
                        textColor: AppColors.blue,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(bottom: Dimen.vertical_padding + 10),
                      alignment: Alignment.topLeft,
                      child: SkyText(
                        freightDetails.paymentMethod.name(),
                        textColor: AppColors.green,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 1,
                      color: AppColors.yellow,
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: Dimen.vertical_padding + 10),
                      alignment: Alignment.topLeft,
                      child: SkyText(
                        "Endereço de carga",
                        textColor: AppColors.blue,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(
                          vertical: Dimen.vertical_padding),
                      child: SkyText(
                        freightDetails.to.formatted ?? "Não informado.",
                        textColor: AppColors.green,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimen.horizontal_padding),
                      child: _openMapButtonFreightOrigin,
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: Dimen.vertical_padding + 10),
                      alignment: Alignment.topLeft,
                      child: SkyText(
                        "Endereço de entrega",
                        textColor: AppColors.blue,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimen.vertical_padding),
                      alignment: Alignment.topLeft,
                      child: SkyText(
                        freightDetails.from.formatted ?? "Não informado.",
                        textColor: AppColors.green,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimen.horizontal_padding),
                      child: _openMapButtonFreightDestiny,
                    ),
                    AppHorizontalDivider(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimen.vertical_padding + 15),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: SkyText(
                                      "Produto",
                                      textColor: AppColors.blue,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: SkyText(
                                      freightDetails.product ??
                                          "Não informado.",
                                      textColor: AppColors.green,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: SkyText(
                                      "Especie",
                                      textColor: AppColors.blue,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: SkyText(
                                      freightDetails.species ??
                                          "Não informado.",
                                      textColor: AppColors.green,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: Dimen.vertical_padding,
                          bottom: Dimen.vertical_padding + 15),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimen.vertical_padding),
                            alignment: Alignment.topLeft,
                            child: SkyText(
                              "Observaçoes",
                              textColor: AppColors.blue,
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimen.vertical_padding),
                            child: SkyText(
                              freightDetails.observation ?? "Não informado.",
                              textAlign: TextAlign.justify,
                              textColor: AppColors.green,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppHorizontalDivider(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimen.horizontal_padding + 15),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: SkyFlatButton(
                              textColor: AppColors.blue,
                              text: freightDetails.freightCompany.name ??
                                  "Não informado.",
                              fontSize: 20,
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.carrierInfo,
                                    arguments: {
                                      "freightCompanyHash":
                                          freightDetails.freightCompany.hash
                                    });
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                bottom: Dimen.horizontal_padding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: starsRating(),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: SkyText(
                              "Localizaçao",
                              textColor: AppColors.blue,
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: SkyText(
                              freightDetails.freightCompany.address.formatted ??
                                  "Não informado.",
                              textColor: AppColors.green,
                              fontSize: 18,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            alignment: Alignment.topLeft,
                            child: SkyText(
                              "Telefone",
                              textColor: AppColors.blue,
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: SkyText(
                              freightDetails.freightCoContact != null
                                  ? Formatter.phone(
                                      freightDetails.freightCoContact)
                                  : "Não informado.",
                              textColor: AppColors.green,
                              fontSize: 18,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            alignment: Alignment.topLeft,
                            child: SkyText(
                              "Colocação na avaliação geral",
                              textColor: AppColors.blue,
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: SkyText(
                              freightDetails.freightCompany.positionInRanking.toString() ??
                                  "Sem colocação",
                              textColor: AppColors.green,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimen.horizontal_padding),
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _openMapButtonCompany,
                            Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 5),
                              child: SkyButton(
                                textColor: AppColors.blue,
                                text: "FALAR COM A EMPRESA",
                                inlineIcon: Icon(
                                  Icons.phone,
                                  color: AppColors.blue,
                                ),
                                buttonColor: AppColors.white,
                                borderRadius: 10,
                                borderColor: AppColors.blue,
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.driverAndFreightChat,
                                    arguments: {
                                      "otherChatMember": ChatMember.from(
                                          freightDetails.freightCompany),
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _proposal(context)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // TODO: Refactor this, the actual object don't have all needed information
  List<Widget> starsRating() {
    List<Widget> list = new List(5);
    int companyRating = freightDetails.freightCompany.rating ?? 0;
    for (int i = 0; i < companyRating; i++) {
      list[i] = new Container(
          child: Icon(
        Icons.star,
        color: AppColors.green,
      ));
    }

    for (int i = companyRating; i < 5; i++) {
      list[i] = new Container(
          child: Icon(
        Icons.star_border,
        color: AppColors.green,
      ));
    }
    return list;
  }

  Widget _proposal(BuildContext context) {
    if (proposal) {
      return new Container(
        child: Column(
          children: <Widget>[
            Container(
              width: 300,
              height: 1,
              color: AppColors.yellow,
            ),
            Container(
              width: 666,
              padding: EdgeInsets.only(top: Dimen.vertical_padding),
              child: AppSaveButton(
                "ACEITAR PROPOSTA",
                onPressed: () {
                  showAppConfirmPopup(
                    context,
                    "ACEITAR PROPOSTA",
                    "Deseja realmente aceitar a proposta?",
                    "SIM",
                    () {
                      // Close the BottomSheet and navigate to AcceptedScreen
                      _freightService
                          .acceptFreightProposal(freightDetails)
                          .then((value) {
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.freightAccepted,
                            (Route<dynamic> route) => route.isFirst);
                      }).catchError((error) {
                        if (error is List<ApiError>) {
                          Navigator.pop(context);
                          showMessageDialog(context,
                              type: DialogType.WARNING,
                              message: error[0].details);
                        }
                      });
                    },
                    cancelOptionTitle: "NÃO",
                    onCancel: () {
                      // Close the BottomSheet
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
            Container(
              width: 666,
              padding: EdgeInsets.only(top: Dimen.vertical_padding),
              child: AppActionButton(
                "RECUSAR PROPOSTA",
                onPressed: () {
                  showAppConfirmPopup(
                    context,
                    "RECUSAR PROPOSTA",
                    "Deseja realmente recusar a proposta?\nVocê nao poderá mais vê-la ou aceitá-la no futuro.",
                    "SIM",
                    () {
                      // Close the BottomSheet and navigate to RefusedScreen
                      _freightService
                          .canRefuseFreightProposal()
                          .then((voidObject) {
                        Navigator.pushNamedAndRemoveUntil(context,
                            Routes.freightRefused, (route) => route.isFirst,
                            arguments: {"freightDetails": freightDetails});
                      }).catchError((error) {
                        if (error is List<ApiError>) {
                          Navigator.pop(context);
                          showMessageDialog(context,
                              type: DialogType.WARNING,
                              message: error[0].details);
                        }
                      });
                    },
                    cancelOptionTitle: "NÃO",
                    onCancel: () {
                      // Close the BottomSheet
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  void _buildMapButtons() {
    _openMapButtonCompany =
        _buildOpenMapButton(freightDetails.freightCompany.address.position);
    _openMapButtonFreightOrigin =
        _buildOpenMapButton(freightDetails.from.position);
    _openMapButtonFreightDestiny =
        _buildOpenMapButton(freightDetails.to.position);
  }

  void _buildBeautifulValues() {
    double nDistance = double.parse(freightDetails.distanceInMeters);
    double nWeight = double.parse(freightDetails.weightInGrams);
    double nAmount = double.parse(freightDetails.valueInCents);
    double nToll = double.parse(freightDetails.tollInCents);
    int nTermDays = int.parse(freightDetails.termInDays);

    distance = Formatter.meterToKilometer(nDistance);
    amount = Formatter.currency.format(nAmount);
    toll = Formatter.currency.format(nToll);
    weight = Formatter.gramsToTon(nWeight);
    termDays = Formatter.days(nTermDays);
  }

  Widget _buildOpenMapButton(LatLng position) {
    num latitude;
    num longitude;

    if (position.latitude != null && position.longitude != null) {
      latitude = num.parse(position.latitude);
      longitude = num.parse(position.longitude);
    } else {
      return Container();
    }

    return Container(
      height: 50,
      width: 200,
      alignment: Alignment.center,
      child: SkyButton(
        textColor: AppColors.blue,
        text: "VER NO MAPA",
        inlineIcon: Icon(
          Icons.location_on,
          color: AppColors.blue,
        ),
        buttonColor: AppColors.white,
        borderRadius: 10,
        borderColor: AppColors.blue,
        onPressed: () {
          MapUtils.openMap(latitude, longitude);
        },
      ),
    );
  }
}

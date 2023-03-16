import 'dart:ui';

import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/constants/whatsapp_constants.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/routes.dart';
import 'package:app_cargo/screens/signup/widget/lucky_number_text.dart';
import 'package:app_cargo/services/chat/chat_service.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:app_cargo/services/driver/driver_service.dart';
import 'package:app_cargo/services/me/me_service.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/app_save_button_second_ui.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/app_text.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LuckyNumber extends StatefulWidget {
  const LuckyNumber({Key key}) : super(key: key);

  @override
  _LuckyNumberState createState() => _LuckyNumberState();
}

class _LuckyNumberState extends State<LuckyNumber> {
  final DriverService driverService = DIContainer().get<DriverService>();
  final ConfigurationService configurationService = DIContainer().get<ConfigurationService>();
  final ChatService chatMessageService = DIContainer().get<ChatService>();
  MeService _meService = DIContainer().get<MeService>();

  Future isRevalidatedLuckyNumber;
  MaskedTextController birthDate;

  String driverBirthDate = '';

  @override
  void initState() {
    super.initState();
    birthDate = new MaskedTextController(mask: '00/00/0000', text: '');

    isRevalidatedLuckyNumber = isLuckyNumberAlreadyRevalidated();

    _meService.getAllDriverData().then((data) {
      setState(() {
        driverBirthDate = data.personal.birthDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double widthDeviceSize = MediaQuery.of(context).size.width;

    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    bool _isFromHome = false;

    if (null != args && args.isNotEmpty) {
      _isFromHome = args["isFromHome"] as bool;
    }

    return AppScaffold(
      showAppBar: false,
      scrollable: false,
      horizontalPadding: 0,
      verticalPadding: 0,
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder(
            future: isRevalidatedLuckyNumber,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  bool isRevalidated = snapshot.data;

                  if (isRevalidated) {
                    return Column(
                      children: <Widget>[
                        Container(
                          height: 120,
                          width: widthDeviceSize,
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ]),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.asset(
                                    "assets/images/logo.png",
                                    height: 45,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                child: AppText(
                                  "NÚMERO DA SORTE",
                                  weight: FontWeight.bold,
                                  textColor: AppColors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15, bottom: 10),
                          child: AppText(
                            "Seu número da sorte é:",
                            textColor: AppColors.green,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            child: SizedBox(
                              height: 100,
                              width: widthDeviceSize,
                              child: Card(
                                  color: AppColors.green,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  child: FutureBuilder(
                                    future: configurationService.luckyNumber,
                                    initialData: -1,
                                    builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.done:
                                          if (snapshot.hasData) {
                                            return Container(
                                              padding: EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  SkyText(
                                                    snapshot.data.toString().padLeft(5, "0"),
                                                    fontSize: 50,
                                                    textColor: AppColors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                          return SizedBox(
                                            width: 1,
                                            height: 1,
                                          );
                                          break;
                                        default:
                                          return SizedBox(
                                            width: 1,
                                            height: 1,
                                          );
                                      }
                                    },
                                  )),
                            )),
                        SizedBox(height: 20),
                        LuckyNumberText(
                          "Aqui na AppCargo tem sorteio TODO MÊS! Por isso cada usuário recebe um número da sorte assim que entrar no App!",
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: Divider(
                            height: 1,
                            color: AppColors.dark_grey02,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 270,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 200,
                                          child: AppText(
                                            "Compartilhe e convide seus amigos clicando no ícone:",
                                            fontSize: 15,
                                            textColor: AppColors.dark_grey02,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              FlutterShare.share(title: "APPCARGO", text: "Venha receber fretes e participar de promoções no AppCargo: https://play.google.com/store/apps/details?id=br.com.appcargo");
                                            },
                                            child: Icon(
                                              Icons.send,
                                              size: 35,
                                              color: AppColors.partner_light_green,
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                          child: AppSaveButtonSecondUI(
                            "IR PARA O MENU PRINCIPAL",
                            onPressed: () {
                              if (_isFromHome != null && _isFromHome) {
                                Navigator.pop(context);
                              } else {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  Routes.index,
                                  (Route<dynamic> route) => false,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        Container(
                          height: 120,
                          width: widthDeviceSize,
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ]),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.asset(
                                    "assets/images/logo.png",
                                    height: 45,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                                child: AppText(
                                  "NÚMERO DA SORTE",
                                  weight: FontWeight.bold,
                                  textColor: AppColors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15, bottom: 10),
                          child: AppText(
                            "Seu número da sorte é:",
                            textColor: AppColors.green,
                          ),
                        ),
                        Container(
                            height: 100,
                            width: widthDeviceSize,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            child: Card(
                                color: AppColors.green,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                child: FutureBuilder(
                                  future: configurationService.luckyNumber,
                                  initialData: -1,
                                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.done:
                                        if (snapshot.hasData) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                ClipRect(
                                                  child: Container(
                                                    height: 60,
                                                    width: 160,
                                                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
                                                    child: Stack(
                                                      children: <Widget>[
                                                        Center(
                                                          child: SkyText(
                                                            snapshot.data.toString().padLeft(5, "0"),
                                                            fontSize: 50,
                                                            textColor: AppColors.white,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        BackdropFilter(
                                                          filter: ImageFilter.blur(
                                                            sigmaX: 10,
                                                            sigmaY: 10,
                                                          ),
                                                          child: Container(
                                                            color: Colors.white.withOpacity(0.0),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        }
                                        return SizedBox(
                                          width: 1,
                                          height: 1,
                                        );
                                        break;
                                      default:
                                        return SizedBox(
                                          width: 1,
                                          height: 1,
                                        );
                                    }
                                  },
                                ))),
                        LuckyNumberText(
                          "Para reativar seu número da sorte, digite sua data de nascimento:",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
                          child: TextField(
                            controller: birthDate,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(hintText: '00/00/0000', border: InputBorder.none),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: Divider(
                            height: 1,
                            color: AppColors.dark_grey02,
                          ),
                        ),
                        Container(
                          height: 70,
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: AppSaveButtonSecondUI(
                            "Reativar".toUpperCase(),
                            onPressed: () {
                              if (birthDate.text != null && birthDate.text != '') {
                                if (driverBirthDate == birthDate.text) {
                                  showLoadingDialog(context);
                                  this.configurationService.driverRevalidatedLuckyNumber().then((result) {
                                    revalidateLuckyNumber().then((result) {
                                      Navigator.pop(context);

                                      showMessageDialog(context, message: "Numero da sorte reativado com sucesso!", type: DialogType.SUCCESS);

                                      setState(() {
                                        isRevalidatedLuckyNumber = isLuckyNumberAlreadyRevalidated();
                                      });
                                    });
                                  });
                                } else {
                                  showMessageDialog(context, message: "A data de nascimento inserida não confere com a sua data de nascimento cadastrada.", type: DialogType.ERROR);
                                }
                              } else {
                                showMessageDialog(context, message: "Forneça uma data de nascimento para continuar.", type: DialogType.ERROR);
                              }
                            },
                          ),
                        ),
                        Container(
                          height: 70,
                          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                          child: AppSaveButtonSecondUI(
                            "IR PARA O MENU PRINCIPAL",
                            onPressed: () {
                              if (_isFromHome != null && _isFromHome) {
                                Navigator.pop(context);
                              } else {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  Routes.index,
                                  (Route<dynamic> route) => false,
                                );
                              }
                            },
                          ),
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: RichText(
                                softWrap: true,
                                textAlign: TextAlign.center,
                                text: TextSpan(style: TextStyle(fontSize: 13, color: AppColors.black), children: <TextSpan>[
                                  TextSpan(text: "Em caso de dúvidas "),
                                  TextSpan(
                                      text: 'clique aqui ',
                                      style: TextStyle(color: Colors.blue),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          String phone = WhatsappConstants.numberWithCountryDDD;
                                          var whatsappUrl = "whatsapp://send?phone=$phone&text=${WhatsappConstants.luckyNumberMessageText}";
                                          if (await canLaunch(whatsappUrl)) {
                                            await launch(whatsappUrl);
                                          }
                                        }),
                                  TextSpan(text: "e fale com a Tatá"),
                                ])),
                          ),
                        )
                      ],
                    );
                  }

                  break;

                default:
                  return AppLoadingWidget();
              }
            },
          ),
        ),
      ),
    );
  }

  Future<bool> isLuckyNumberAlreadyRevalidated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isRevalidated = prefs.getBool('is_already_revalidated');

    if (isRevalidated == null) {
      prefs.setBool('is_already_revalidated', false);
      return false;
    }
    if (isRevalidated != null && !isRevalidated) {
      return false;
    }
    if (isRevalidated != null && isRevalidated) {
      return true;
    }
    return false;
  }

  Future<bool> revalidateLuckyNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('is_already_revalidated', true);
  }
}

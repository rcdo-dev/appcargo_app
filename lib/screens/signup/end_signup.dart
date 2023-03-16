import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/routes.dart';
import 'package:app_cargo/screens/signup/widget/lucky_number_text.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_save_button_second_ui.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class EndSignUp extends StatelessWidget {
  final ConfigurationService configurationService =
      DIContainer().get<ConfigurationService>();

  Widget build(BuildContext context) {
    final double widthDeviceSize = MediaQuery.of(context).size.width;

    return AppScaffold(
      showAppBar: false,
      scrollable: false,
      horizontalPadding: 0,
      verticalPadding: 0,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.asset(
                          "assets/images/logo.png",
                          height: 45,
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: FutureBuilder(
                          future: configurationService.luckyNumber,
                          initialData: -1,
                          builder: (BuildContext context,
                              AsyncSnapshot<int> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.done:
                                if (snapshot.hasData) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Dimen.horizontal_padding),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SkyText(
                                          snapshot.data
                                              .toString()
                                              .padLeft(5, "0"),
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
                                    FlutterShare.share(
                                        title: "APPCARGO",
                                        text:
                                            "Venha receber fretes e participar de promoções no AppCargo: https://play.google.com/store/apps/details?id=br.com.appcargo");
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
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.menu,
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

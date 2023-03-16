import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/screens/settings/help/widget/AppVersionWidget.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';
import 'package:app_cargo/services/config/config_service.dart';

class SettingsAbout extends StatelessWidget {
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
                          Icons.description,
                          size: 25,
                          color: AppColors.blue,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimen.vertical_padding,
                            horizontal: Dimen.horizontal_padding - 5),
                        child: SkyText(
                          "SOBRE O APPCARGO",
                          fontSize: 25,
                          textColor: AppColors.blue,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimen.vertical_padding + 10),
                  child: SkyText(
                    "O AppCargo é uma solução que procura reduzir distâncias, aproximando motoristas de transportadoras e permitindo que o tempo seja otimizado e os custos reduzidos.",
                    textColor: AppColors.blue,
                    fontSize: 16,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimen.vertical_padding + 10),
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 120,
                    ),
                  ),
                ),
                AppVersionWidget(),
              ],
            ),
          ),
          /*Container(
            child: SkyFlatButton(
              fontSize: 18,
              textColor: AppColors.blue,
              text: "Problemas?\nChama no Whats!",
              // TODO: This button needs to Open WhatsApp
            ),
          )*/
        ],
      ),
    );
  }
}
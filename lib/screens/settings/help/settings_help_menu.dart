import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:app_cargo/widgets/app_action_button.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../../routes.dart';

class SettingsHelpMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "CONFIGURAÇÕES",
      body: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                /*Container(
                  padding:
                  EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
                  child: SkyButton(
                    text: "DUVIDAS",
                    inlineIcon: Icon(
                      Icons.help,
                      size: 30,
                      color: AppColors.yellow,
                    ),
                    textColor: AppColors.blue,
                    buttonColor: AppColors.white,
                    borderRadius: 10,
                    fontSize: 25,
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.settingsDoubts);
                    },
                  ),
                ),*/
                /*Container(
                  padding:
                      EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
                  child: SkyButton(
                    text: "CHAMAR NO WHATS",
                    inlineIcon: Icon(
                      Icons.phone,
                      size: 30,
                      color: AppColors.yellow,
                    ),
                    textColor: AppColors.blue,
                    buttonColor: AppColors.white,
                    borderRadius: 10,
                    fontSize: 25,
                    onPressed: () {
                      // TODO: This button needs to open WhatsApp
                    },
                  ),
                ),*/
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
                  child: SkyButton(
                    text: "SOBRE O APPCARGO",
                    inlineIcon: Icon(
                      Icons.description,
                      size: 25,
                      color: AppColors.yellow,
                    ),
                    textColor: AppColors.blue,
                    buttonColor: AppColors.white,
                    borderRadius: 10,
                    fontSize: 25,
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.settingsAbout);
                    },
                  ),
                ),
                Container(
                  padding:
                  EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
                  child: SkyButton(
                    text: "SAIR",
                    inlineIcon: Icon(
                      Icons.directions_run,
                      size: 25,
                      color: AppColors.yellow,
                    ),
                    textColor: AppColors.blue,
                    buttonColor: AppColors.white,
                    borderRadius: 10,
                    fontSize: 25,
                    onPressed: () {
                      DIContainer().get<ConfigurationService>().deleteAccessToken();
                      Navigator.pushNamedAndRemoveUntil(context, Routes.index, (object) => false);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

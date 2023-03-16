import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:app_cargo/widgets/app_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

void showNewRegistrationInfo(BuildContext context) async {
  ConfigurationService _configurationService =
      DIContainer().get<ConfigurationService>();
  int registrationTimes = await _configurationService.newRegistrationModalShow;
  if (registrationTimes > 0) {
    _configurationService.setNewRegistrationModalShow(
        newValue: registrationTimes - 1);
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          elevation: 10,
          backgroundColor: AppColors.white,
          title: Container(
            padding: EdgeInsets.all(Dimen.vertical_padding),
            child: SkyText(
              "Atenção",
              textAlign: TextAlign.center,
              fontSize: 25,
              textColor: AppColors.green,
            ),
          ),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(Dimen.horizontal_padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimen.horizontal_padding),
                    child: SkyText(
                      "Os seus dados que podem ser alterados aparecem com um contorno preto. Alguns outros, que não podem ser alterados, aparecem com um contorno cinza claro.",
                      textAlign: TextAlign.justify,
                      fontSize: 17,
                      textColor: AppColors.blue,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimen.horizontal_padding),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.green)),
                    child: Column(
                      children: <Widget>[
                        AppTextField(
                          label: "Pode ser alterado",
                          hint: "Alterável",
                        ),
                        AppTextField(
                          label: "Não pode ser alterado",
                          hint: "Não alterável",
                          enable: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

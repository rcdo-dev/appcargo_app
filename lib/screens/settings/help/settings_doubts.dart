import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/screens/settings/help/widget/AppHelpOption.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../../routes.dart';

class SettingsDoubts extends StatelessWidget {
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
                          Icons.help,
                          size: 25,
                          color: AppColors.blue,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimen.vertical_padding,
                            horizontal: Dimen.horizontal_padding - 5),
                        child: SkyText(
                          "DÚVIDAS",
                          fontSize: 25,
                          textColor: AppColors.blue,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: AppHelpOption(
                    "LOREN IPSUM DOLOR SIT AMET ?",
                    "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat.",
                    titleSize: 17,
                    titleColor: AppColors.blue,
                    descriptionSize: 15,
                    descriptionColor: AppColors.light_blue,
                    hasIcon: true,
                  ),
                ),
                Container(
                  child: AppHelpOption(
                    "LOREN IPSUM DOLOR SIT AMET ?",
                    "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat.",
                    titleSize: 17,
                    titleColor: AppColors.blue,
                    descriptionSize: 15,
                    descriptionColor: AppColors.light_blue,
                    hasIcon: true,
                  ),
                ),
                Container(
                  child: AppHelpOption(
                    "LOREN IPSUM DOLOR SIT AMET ?",
                    "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat.",
                    titleSize: 17,
                    titleColor: AppColors.blue,
                    descriptionSize: 15,
                    descriptionColor: AppColors.light_blue,
                    hasIcon: true,
                  ),
                ),
                Container(
                  child: AppHelpOption(
                    "LOREN IPSUM DOLOR SIT AMET ?",
                    "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat.",
                    titleSize: 17,
                    titleColor: AppColors.blue,
                    descriptionSize: 15,
                    descriptionColor: AppColors.light_blue,
                    hasIcon: true,
                  ),
                ),
                Container(
                  child: AppHelpOption(
                    "LOREN IPSUM DOLOR SIT AMET ?",
                    "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat.",
                    titleSize: 17,
                    titleColor: AppColors.blue,
                    descriptionSize: 15,
                    descriptionColor: AppColors.light_blue,
                    hasIcon: true,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: SkyFlatButton(
              fontSize: 18,
              textColor: AppColors.blue,
              text: "Ainda com dúvidas? Chama no Whats!",
              // TODO: This button needs to Open WhatsApp
            ),
          )
        ],
      ),
    );
  }
}

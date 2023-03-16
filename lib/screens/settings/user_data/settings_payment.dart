import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../../routes.dart';

class SettingsPayment extends StatelessWidget {
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
                          Icons.credit_card,
                          size: 25,
                          color: AppColors.blue,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimen.vertical_padding,
                            horizontal: Dimen.horizontal_padding - 5),
                        child: SkyText(
                          "PAGAMENTO",
                          fontSize: 25,
                          textColor: AppColors.blue,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
                  child: SkyText(
                    "Metodo Cadastrado",
                    textColor: AppColors.green,
                    fontSize: 20,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimen.vertical_padding,
                      horizontal: Dimen.vertical_padding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(right: Dimen.horizontal_padding),
                        width: 60,
                        height: 40,
                        child: Image.asset("assets/images/600x400.png"),
                      ),
                      Container(
                        child: SkyText("•••• •••• •••• 1051",
                            fontSize: 15, textColor: AppColors.blue),
                      )
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
                  child: SkyText(
                    "Metodo de Pagamento",
                    textColor: AppColors.green,
                    fontSize: 20,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
                  child: SkyText(
                    "Cartao de Credito",
                    textColor: AppColors.blue,
                    fontSize: 20,
                  ),
                ),
                AppSaveButton("DETLHES DA COBRANÇA", onPressed: () {
                  Navigator.pushNamed(context, Routes.settingsBillingDetails);
                },),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

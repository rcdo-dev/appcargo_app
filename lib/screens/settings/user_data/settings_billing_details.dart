import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/screens/settings/user_data/widget/AppNextInvoices.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../../routes.dart';

class SettingsBillingDetails extends StatelessWidget {
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
                          size: 20,
                          color: AppColors.blue,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimen.vertical_padding,
                            horizontal: Dimen.horizontal_padding - 5),
                        child: SkyText(
                          "DETALHES DE COBRANÇA",
                          fontSize: 20,
                          textColor: AppColors.blue,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                      border: Border.all(
                          style: BorderStyle.solid, color: AppColors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  padding: EdgeInsets.symmetric(
                      vertical: Dimen.vertical_padding,
                      horizontal: Dimen.horizontal_padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimen.vertical_padding),
                        child: SkyText(
                          "Sua proxima fatura",
                          textAlign: TextAlign.start,
                          fontSize: 15,
                          textColor: AppColors.blue,
                        ),
                      ),
                      Container(
                        child: SkyText(
                          "R\$32,90/mês",
                          textAlign: TextAlign.start,
                          fontSize: 20,
                          textColor: AppColors.green,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: Dimen.vertical_padding + 15,
                            bottom: Dimen.vertical_padding),
                        child: SkyText(
                          "Data da proxíma fatura",
                          textAlign: TextAlign.start,
                          fontSize: 15,
                          textColor: AppColors.blue,
                        ),
                      ),
                      Container(
                        child: SkyText(
                          "9 de setembro de 2019",
                          textAlign: TextAlign.start,
                          fontSize: 20,
                          textColor: AppColors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: Dimen.vertical_padding,
                      bottom: Dimen.vertical_padding + 15),
                  width: 250,
                  child: SkyText(
                    "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore",
                    fontSize: 15,
                    textColor: AppColors.blue,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Container(
                  width: 300,
                  height: 1,
                  color: AppColors.yellow,
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: Dimen.vertical_padding + 15,
                      bottom: Dimen.vertical_padding,
                      left: Dimen.horizontal_padding,
                      right: Dimen.horizontal_padding),
                  child: AppNextInvoices(
                    cardBanner: "assets/images/600x400.png",
                    invoiceDate: "09/08/2019",
                    lastFourDigitsCard: "1051",
                    paymentCreationDate: "09/08/2019",
                    paymentExpirationDate: "09/09/2019",
                    invoiceAmount: "R\$32,90",
                  ),
                ),
                Container(
                  width: 300,
                  height: 1,
                  color: AppColors.yellow,
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: Dimen.vertical_padding + 15,
                      bottom: Dimen.vertical_padding,
                      left: Dimen.horizontal_padding,
                      right: Dimen.horizontal_padding),
                  child: AppNextInvoices(
                    cardBanner: "assets/images/600x400.png",
                    invoiceDate: "09/08/2019",
                    lastFourDigitsCard: "1051",
                    paymentCreationDate: "09/07/2019",
                    paymentExpirationDate: "09/08/2019",
                    invoiceAmount: "R\$32,90",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

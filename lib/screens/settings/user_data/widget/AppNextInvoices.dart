import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/src/widgets/sky_text.dart';

class AppNextInvoices extends StatelessWidget {
  final String invoiceDate;
  final String paymentCreationDate;
  final String paymentExpirationDate;
  final String cardBanner;
  final String lastFourDigitsCard;
  final String invoiceAmount;

  const AppNextInvoices(
      {Key key,
      this.invoiceDate,
      this.paymentCreationDate,
      this.paymentExpirationDate,
      this.cardBanner,
      this.lastFourDigitsCard,
      this.invoiceAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(
                        vertical: Dimen.vertical_padding,
                        horizontal: Dimen.vertical_padding),
                    child: SkyText(invoiceDate,
                        fontSize: 24, textColor: AppColors.green),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(
                        vertical: Dimen.vertical_padding,
                        horizontal: Dimen.vertical_padding),
                    child: SkyText(invoiceAmount,
                        fontSize: 24, textColor: AppColors.blue),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dimen.vertical_padding,
                horizontal: Dimen.vertical_padding),
            child: SkyText("Mensalidade AppCargo",
                fontSize: 15, textColor: AppColors.blue),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dimen.vertical_padding,
                horizontal: Dimen.vertical_padding),
            child: SkyText(paymentCreationDate + " - " + paymentExpirationDate,
                fontSize: 15, textColor: AppColors.blue),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dimen.vertical_padding,
                horizontal: Dimen.vertical_padding),
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: Dimen.horizontal_padding),
                  width: 60,
                  height: 40,
                  child: Image.asset(cardBanner),
                ),
                Container(
                  child: SkyText("•••• •••• •••• " + lastFourDigitsCard,
                      fontSize: 15, textColor: AppColors.blue),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/whatsapp_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> appDialogLoginWithoutBirthDate(BuildContext context) async{
  await showDialog(
      barrierDismissible: true,
      context: context,
      child: SimpleDialog(
        title: SkyText(
          "Ação necessária",
          fontSize: 22,
          fontWeight: FontWeight.bold,
          textColor: AppColors.green,
        ),
        children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: SkyText(
                "Ligue ou mande uma mensagem para a Tata pelo número 11958577887 e altere a sua senha para a sua data de nascimento.",
                fontSize: 17,
                textAlign: TextAlign.left,
              )),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 100,
                  child: RaisedButton(
                    onPressed: () async {
                      // String phone = "+5511958577887";
                      String phone = WhatsappConstants.numberWithCountryDDD;
                      var whatsappUrl =
                          "whatsapp://send?phone=$phone&text=${WhatsappConstants.messageText}";
                      if (await canLaunch(whatsappUrl)) {
                        await launch(whatsappUrl);
                      }
                    },
                    child: Text("Mensagem"),
                    textColor: AppColors.white,
                    color: AppColors.green,
                  ),
                ),
                Container(
                  width: 100,
                  child: RaisedButton(
                    onPressed: () async {
                      if (await canLaunch("tel:${WhatsappConstants.numberWithoutCountryDDD}")) {
                        await launch("tel:11958577887");
                      }
                    },
                    child: Text("Ligar"),
                    textColor: AppColors.white,
                    color: AppColors.green,
                  ),
                ),
              ],
            ),
          )
        ],
      ));
}

import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/whatsapp_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDialogPremiumUserPlan {
  GlobalKey<ScaffoldState> key;
  String initialMessageText;

  AppDialogPremiumUserPlan({
    this.key,
    this.initialMessageText,
  });

  Future<void> showPremiumDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        child: SimpleDialog(
          title: Column(
            children: <Widget>[
              CircleAvatar(
                maxRadius: 48,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    "assets/images/ic_tata_update.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SkyText(
                "Aviso da Tatá",
                fontSize: 22,
                fontWeight: FontWeight.bold,
                textColor: AppColors.blue,
              ),
            ],
          ),
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: RichText(
                softWrap: true,
                text: TextSpan(
                  style: TextStyle(fontSize: 15, color: AppColors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: "A Tatá te ajuda."
                          " Entre em contato agora com ela pelo WhatsApp: ",
                    ),
                    TextSpan(
                      text: '${WhatsappConstants.premiumTataContactNumber}.',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _sendWhatsappMessage(
                            messageText: initialMessageText,
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 2, horizontal: 25),
              child: RaisedButton(
                onPressed: () {
                  _sendWhatsappMessage(
                    messageText: initialMessageText,
                  );
                },
                child: Text("Enviar mensagem"),
                textColor: AppColors.white,
                color: AppColors.green,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 2, horizontal: 25),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Fechar"),
                textColor: AppColors.white,
                color: Colors.red[300],
              ),
            )
          ],
        ));
  }

  void _sendWhatsappMessage({String messageText}) async {
    var whatsappUrl = "whatsapp://send?phone="
        "${WhatsappConstants.formattedPremiumTataContactNumber}"
        "&text=$messageText";
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      var snackbar = SnackBar(
        backgroundColor: AppColors.red,
        content: Text(
          'Instale o WHATSAPP para falar com a Tatá',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
      );
      key.currentState.showSnackBar(snackbar);
    }
  }
}

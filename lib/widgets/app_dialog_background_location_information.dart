import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';
class AppDialogBackgroundLocationInformation{

  static Future<void> notifyUserThatAppUsesBackgroundLocation(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        child: SimpleDialog(
          title: SkyText(
            "Permissões solicitadas",
            fontSize: 22,
            fontWeight: FontWeight.bold,
            textColor: AppColors.green,
          ),
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: SkyText(
                  "Este aplicativo coleta dados de localização para poder oferecer fretes próximos a onde você está no momento, mesmo quando o aplicativo está fechado ou não está em uso.",
                  fontSize: 17,
                  textAlign: TextAlign.left,
                )),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Entendi"),
                textColor: AppColors.white,
                color: AppColors.green,
              ),
            )
          ],
        ));
  }



}

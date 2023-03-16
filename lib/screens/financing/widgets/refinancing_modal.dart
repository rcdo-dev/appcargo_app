import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

Future showRefinancingModal(
    BuildContext context, String title, String content) {
  double minWidth = 110;

  List<Widget> buttons = [
    ButtonTheme(
      minWidth: minWidth,
      child: FlatButton(
        color: AppColors.green,
        child: Text(""),
        textColor: AppColors.white,
        onPressed: () {
          Navigator.pop(context, false);
        },
      ),
    ),
    ButtonTheme(
      minWidth: minWidth,
      child: FlatButton(
        color: AppColors.green,
        child: Text("TEST"),
        textColor: AppColors.white,
        onPressed: () {
          Navigator.pop(context, true);
        },
      ),
    ),
  ];

  return buildRefinancingModal(context, title, content, buttons);
}

Future buildRefinancingModal(
    BuildContext context, String title, String content, List<Widget> buttons) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return ButtonBarTheme(
          data: ButtonBarThemeData(alignment: MainAxisAlignment.center),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            backgroundColor: AppColors.white,
            titlePadding: EdgeInsets.all(0),
            content: Container(
              height: (MediaQuery.of(context).size.height / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title.toUpperCase(),
                      style: TextStyle(
                          color: AppColors.light_green,
                          fontSize: 19,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                      // "Em até 2 horas você receberá uma notificação com o status da sua solicitação.",
                      content,
                      style: TextStyle(
                        color: AppColors.dark_grey02,
                        fontSize: 15,
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  RichText(
                      softWrap: true,
                      text: TextSpan(
                          style:
                              TextStyle(fontSize: 12, color: AppColors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: "VOCÊ PODE TAMBÉM CONSULTAR O STATUS EM ",
                                style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                      context, Routes.userRequests);
                                },
                              text: '\"MINHAS SIMULAÇÕES\"',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ])),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 100,
                        child: Image(
                          image: AssetImage("assets/images/logoMenu.png"),
                          color: Colors.grey[350],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            // actions: buttons,
          ),
        );
      });
}

import 'package:app_cargo/constants/dimen.dart';
import 'package:flutter_skywalker_core/src/widgets/sky_text.dart';
import 'package:flutter/material.dart';
import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../routes.dart';

class RecoverPassword4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PlatformScaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background/fundo2@3x.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  padding:
                      EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 120,
                    ),
                  )),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimen.horizontal_padding,
                    vertical: Dimen.vertical_padding),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SkyText(
                    "Tela de contato",
                    fontSize: 35,
                    textColor: AppColors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimen.horizontal_padding,
                    vertical: Dimen.vertical_padding),
                child: Container(
                  height: 300,
                  width: 500,
                  decoration: new BoxDecoration(
                      color: AppColors.white,
                      borderRadius: new BorderRadius.all(Radius.circular(10))),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimen.horizontal_padding,
                      vertical: Dimen.vertical_padding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimen.vertical_padding),
                          child: SkyText(
                            "Em desenvolvimento",
                            textColor: AppColors.blue,
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

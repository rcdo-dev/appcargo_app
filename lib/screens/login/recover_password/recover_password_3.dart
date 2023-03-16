import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:flutter/material.dart';
import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../../routes.dart';

class RecoverPassword3 extends StatelessWidget {
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
                    "LEMBRAR SENHA",
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
                  decoration: new BoxDecoration(
                      color: AppColors.white,
                      borderRadius: new BorderRadius.all(Radius.circular(10))),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimen.horizontal_padding,
                      vertical: Dimen.vertical_padding),
                  child: Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimen.vertical_padding),
                          child: SkyText(
                            "Tente novamente e aguarde\n5 minutos, caso não receba o código\nentre em contato conosco no\nbotão abaixo!",
                            textColor: AppColors.blue,
                            textAlign: TextAlign.center,
                            fontSize: 18,
                          )),
                      AppSaveButton(
                        "TENTAR NOVAMENTE",
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.recoverPassword);
                        },
                      ),
                      AppSaveButton(
                        "ENTRAR EM CONTATO",
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.recoverPassword4);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: SkyFlatButton(
                  textColor: AppColors.blue,
                  fontSize: 15,
                  text: "Voltar a tela de inicio",
                  onPressed: () {
                    Navigator.popAndPushNamed(context, Routes.signIn);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

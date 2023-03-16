import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/services/recover_password/recover_password_service.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../../routes.dart';

class RecoverPassword extends StatelessWidget {
  final TextEditingController email =
      new TextEditingController(text: "");
  final RecoverPasswordService _recoverPasswordService =
      DIContainer().get<RecoverPasswordService>();

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
                    vertical: Dimen.horizontal_padding),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SkyText(
                    "ESQUECI A SENHA",
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
                        child: AppTextField(
                          labelColor: AppColors.blue,
                          label: "E-Mail",
                          prefixIcon: Icon(
                            Icons.mail_outline,
                            color: AppColors.yellow,
                          ),
                          textEditingController: email,
                          inputType:
                              TextInputType.emailAddress
                        ),
                      ),
                      AppSaveButton(
                        "LEMBRAR SENHA",
                        onPressed: () {
                          showLoadingThenOkDialog(
                                  context,
                                  _recoverPasswordService
                                      .requestRecoverPassword(email.text));
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
                  text: "Eu sei a senha",
                  onPressed: () {
                    return Navigator.pop(context);
                  },
                ),
              ),
              Container(
                child: SkyFlatButton(
                  textColor: AppColors.blue,
                  fontSize: 15,
                  text: "Quero me cadastrar",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/services/recover_password/recover_password_service.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_password_field.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../../routes.dart';

class RecoverPassword2 extends StatefulWidget {
  final RecoverPasswordService _recoverPasswordService =
      DIContainer().get<RecoverPasswordService>();

  @override
  State<StatefulWidget> createState() =>
      _RecoverPassword2State(_recoverPasswordService);
}

class _RecoverPassword2State extends State<RecoverPassword2> {
  final RecoverPasswordService _recoverPasswordService;
  String _phoneNumber;
  TextEditingController _validationCode;
  TextEditingController _password;
  TextEditingController _repeatPassword;

  _RecoverPassword2State(this._recoverPasswordService);

  void initState() {
    _validationCode = new TextEditingController();
    _password = new TextEditingController();
    _repeatPassword = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    if (null != args && args.isNotEmpty) {
      _phoneNumber = args["phoneNumber"] as String;
    }
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
                        child: AppTextField(
                          labelColor: AppColors.blue,
                          label: "Codigo recebido no seu celular de número: " +
                              _phoneNumber,
                          prefixIcon: Icon(
                            Icons.message,
                            color: AppColors.yellow,
                          ),
                          style: TextStyle(fontSize: 15, height: 0.4),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: AppPasswordField("Nova Senha"),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: AppPasswordField("Repetir Nova Senha"),
                      ),
                      AppSaveButton(
                        "TROCAR A SENHA",
                        onPressed: () {
//                          showLoadingThenOkDialog(
//                                  context,
//                                  _recoverPasswordService.doRecoverPassword(
//                                      _phoneNumber,
//                                      _validationCode.text,
//                                      _password.text,
//                                      _repeatPassword.text))
//                              .then((value) {
//                            if (value != null) {
//                              Navigator.pop(context);
//                            }
//                          });
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
                  text: "Nao recebi o SMS com o codigo",
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Routes.recoverPassword3);
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

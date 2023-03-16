import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/build_data.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/constants/analytics_events_constants.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/login_response/login_response.dart';
import 'package:app_cargo/i18n/localization.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:app_cargo/services/user/user_service.dart';
import 'package:app_cargo/widgets/app_confirm_popup.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_save_button_second_ui.dart';
import 'package:app_cargo/widgets/app_text.dart';
import 'package:app_cargo/widgets/app_text_button.dart';
import 'package:app_cargo/widgets/app_text_field_second_ui.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../routes.dart';

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatefulWidgetState();
}

class _StatefulWidgetState extends State<StatefulWidget> {
  UserService userService = DIContainer().get<UserService>();
  final ConfigurationService configService =
      DIContainer().get<ConfigurationService>();
  Future<String> _accessTokenFuture;

  FacebookAppEvents _facebookAppEvents = DIContainer().get<FacebookAppEvents>();
  final FirebaseAnalytics _firebaseAnalytics =
      DIContainer().get<FirebaseAnalytics>();

  // TextEditingController _login, _password;
  TextEditingController _truckPlate,
      _birthDate,
      _cpf,
      _confirmCpf,
      _confirmBirthDate;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // _login = TextEditingController();
    // _password = new TextEditingController();
    _facebookAppEvents.setAutoLogAppEventsEnabled(true);
    _birthDate = new MaskedTextController(mask: "00/00/0000", text: "");
    _truckPlate = new MaskedTextController(mask: "AAA0@00", text: "");
    _cpf = new MaskedTextController(mask: "000.000.000-00", text: "");
    _confirmCpf = new MaskedTextController(mask: "000.000.000-00", text: "");
    _confirmBirthDate = new MaskedTextController(mask: "00/00/0000", text: "");
  }

  void _goToSignUp(BuildContext context) {
    showAppConfirmPopup(
      context,
      AppLocalization.of(context).alertNewAccount,
      AppLocalization.of(context).alertNewAccountDescription,
      AppLocalization.of(context).actionWannaSignUp,
      () {
        // Close the BottomSheet and navigate to SignUp
        Navigator.of(context).pop();
        Navigator.pushNamed(context, Routes.signUp);
      },
      cancelOptionTitle: AppLocalization.of(context).actionMaybeLater,
      onCancel: () {
        // Close the BottomSheet
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new PlatformScaffold(
      backgroundColor: AppColors.white,
      body: Container(
        decoration: BoxDecoration(color: AppColors.white),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      child: Container(
                    height: 270,
                    width: MediaQuery.of(context).size.width,
                    child: Image(
                      image: AssetImage('assets/images/ic_header02.png'),
                      fit: BoxFit.cover,
                    ),
                  )),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: SizedBox(
                      height: 250,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 10,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.only(bottom: 20),
                          child: AppText(
                            "Bem vindo!",
                            weight: FontWeight.bold,
                            textColor: AppColors.green,
                            textAlign: TextAlign.center,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      child: Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    child: Image(
                      image: AssetImage('assets/images/ic_header.png'),
                      fit: BoxFit.cover,
                    ),
                  )),
                  FractionalTranslation(
                    translation: Offset(0.0, 0.5),
                    child: new Container(
                      alignment: Alignment.center,
                      height: 130,
                      decoration: new BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: FittedBox(
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minWidth: 1, minHeight: 1),
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: 70,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 280),
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimen.horizontal_padding,
                        vertical: Dimen.vertical_padding),
                    child: Container(
                      decoration: new BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              new BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimen.horizontal_padding,
                          vertical: Dimen.vertical_padding),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimen.vertical_padding),
                            child: AppTextFieldSecondUI(
                              textEditingController: _truckPlate,
                              labelColor: AppColors.dark_grey02,
                              labelBold: FontWeight.bold,
                              inputType: TextInputType.emailAddress,
                              label: "Placa",
                              hint: "xxx0x00",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimen.vertical_padding),
                            child: AppTextFieldSecondUI(
                              label: "Data de nascimento",
                              labelColor: AppColors.dark_grey02,
                              labelSize: 14,
                              labelBold: FontWeight.bold,
                              hint: "00/00/0000",
                              textEditingController: _birthDate,
                              inputType: TextInputType.datetime,
                            ),
                          ),
                          if (BuildData.isDebugMode)
                            AppSaveButton(
                              "PREENCHER",
                              onPressed: () {
                                // _login.text = "ioxua.oliveira@gmail.com";
                                // _password.text = "Motorista@123";
                                // _login.text = "g.luzsilva1@gmail.com";
                                // _password.text = "75309753";

                                _truckPlate.text = "abc1234";
                                _birthDate.text = "10/04/2001";

                                _doLogin(context);
                              },
                            ),
                          AppSaveButtonSecondUI(
                            "ENTRAR",
                            textColor: AppColors.black,
                            textWeight: FontWeight.bold,
                            autofocus: true,
                            onPressed: () {
                              if (validate()) {
                                _doLogin(context);
                              } else {
                                showMessageDialog(context,
                                    message:
                                        "Preencha todos os campos corretamente");
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              AppTextButton(
                "Quero me cadastrar!",
                textColor: AppColors.black,
                onClick: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, Routes.signUp);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _doLogin(BuildContext context) async {
    showLoadingThenOkDialog(
      context,
      userService.loginV3(
        _truckPlate.text,
        _birthDate.text,
      ),
      error: "Seu usuário e/ou senha são inválidos!",
    ).then(
      (result) async {
        print(result);
        if (result != null && result is LoginResponse) {
          String loginRule;
          await configService.setAccessToken(result.accessToken);
          await configService.setDriverHash(result.hash);
          await configService.setLuckyNumber(result.luckyNumber);

          String to = Routes.luckyNumber;

          if (result.role == "PARTNER_ADMIN") {
            to = Routes.menuCompany;
            loginRule = AnalyticsEventsConstants.partner;
          }

          if (BuildData.isDebugMode && result.role == "DRIVER") {
            to = Routes.index;
            loginRule = AnalyticsEventsConstants.driver;
          }

          _facebookAppEvents.logActivatedApp();
          _facebookAppEvents.logEvent(
              name: AnalyticsEventsConstants.loginEffectuated,
              parameters: {AnalyticsEventsConstants.loginRule: loginRule});
          _firebaseAnalytics.logEvent(
              name: AnalyticsEventsConstants.loginEffectuated,
              parameters: {AnalyticsEventsConstants.loginRule: loginRule});

          if (to == Routes.luckyNumber) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                to, (Route<dynamic> route) => false,
                arguments: {"isFromHome": false});
          } else {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(to, (Route<dynamic> route) => false);
          }
        } else if (result ==
            'A data de nascimento do motorista está incorreta\n') {
          _updateLoginCredentials(
            context,
            plate: _truckPlate.text,
            birthDate: _birthDate.text,
          );
        }
      },
    );
  }

  bool validate() {
    String birthDate = _birthDate.text;
    String truckPlate = _truckPlate.text;

    if (birthDate.isEmpty) {
      return false;
    }

    if (truckPlate.isEmpty) {
      return false;
    }

    return true;
  }

  void _updateLoginCredentials(
    BuildContext context, {
    String plate,
    String birthDate,
  }) {
    _cpf.clear();
    _confirmCpf.clear();
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Padding(
          padding: EdgeInsets.all(
            20.0,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  AppText.defaultText(
                    '1. Motorista, antes de atualizar verifique se você digitou certo a sua DATA DE NASCIMENTO!',
                    bold: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: AppText(
                      'DATA INFORMADA: $birthDate',
                      textColor: AppColors.red,
                      fontSize: 20,
                      weight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AppText.defaultText(
                    '2. Se você digitou errado, aperte o botão CANCELAR para voltar a tela anterior e corrigir a data de nascimento.',
                    bold: true,
                  ),
                  Divider(
                    height: 45,
                    thickness: 5.0,
                    color: AppColors.black,
                  ),
                  AppText.fieldLabel(
                    '3. Digite os dados abaixo para atualizá-los.',
                  ),
                  SizedBox(
                    height: 05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'CPF',
                        style: TextStyle(
                          color: AppColors.dark_grey02,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.light_grey02,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
                            controller: _cpf,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '000.000.000-00',
                            ),
                            validator: (value) {
                              if (value.isEmpty || value == null) {
                                return 'Dado inválido';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Confirme o CPF',
                        style: TextStyle(
                          color: AppColors.dark_grey02,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.light_grey02,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
                            controller: _confirmCpf,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '000.000.000-00',
                            ),
                            validator: (value) => validateData(
                              value,
                              comparedValue: _cpf.text,
                              field: 'CPF',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Confirme a data de nascimento',
                        style: TextStyle(
                          color: AppColors.dark_grey02,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.light_grey02,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
                            controller: _confirmBirthDate,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '00/00/0000',
                            ),
                            validator: (value) => validateData(
                              value,
                              comparedValue: _birthDate.text,
                              field: 'Nascimento',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      AppSaveButton(
                        'Atualizar',
                        buttonWidth: MediaQuery.of(context).size.width * 0.3,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            var cpf = _cpf.text
                                .replaceAll('.', '')
                                .replaceAll('-', '');
                            _doLoginUpdatingData(context, cpf);
                          }
                        },
                      ),
                      AppSaveButton(
                        'Cancelar',
                        buttonWidth: MediaQuery.of(context).size.width * 0.3,
                        buttonColor: AppColors.red,
                        onPressed: () {
                          Navigator.pop(context);
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String validateData(String value, {String comparedValue, String field}) {
    if (value.isEmpty || value == null) {
      return 'Dado inválido';
    } else if (value != comparedValue) {
      return 'O $field não corresponde com o informado!';
    }
    return null;
  }

  void _doLoginUpdatingData(BuildContext context, String cpf) async {
    showLoadingThenOkDialog(
      context,
      userService.loginV3(
        _truckPlate.text,
        _birthDate.text,
        cpf: cpf,
      ),
      error: "CPF inválido!",
    ).then(
      (result) async {
        if (result != null) {
          String loginRule;
          await configService.setAccessToken(result.accessToken);
          await configService.setDriverHash(result.hash);
          await configService.setLuckyNumber(result.luckyNumber);

          String to = Routes.luckyNumber;

          if (result.role == "PARTNER_ADMIN") {
            to = Routes.menuCompany;
            loginRule = AnalyticsEventsConstants.partner;
          }

          if (BuildData.isDebugMode && result.role == "DRIVER") {
            to = Routes.index;
            loginRule = AnalyticsEventsConstants.driver;
          }

          _facebookAppEvents.logActivatedApp();
          _facebookAppEvents.logEvent(
              name: AnalyticsEventsConstants.loginEffectuated,
              parameters: {AnalyticsEventsConstants.loginRule: loginRule});
          _firebaseAnalytics.logEvent(
              name: AnalyticsEventsConstants.loginEffectuated,
              parameters: {AnalyticsEventsConstants.loginRule: loginRule});

          if (to == Routes.luckyNumber) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                to, (Route<dynamic> route) => false,
                arguments: {"isFromHome": false});
          } else {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(to, (Route<dynamic> route) => false);
          }
        }
      },
    );
  }
}

import 'dart:io';

import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/i18n/localization.dart';
import 'package:app_cargo/screens/signup/signup_base_step.dart';
import 'package:app_cargo/screens/signup/signup_step1.dart';
import 'package:app_cargo/screens/signup/signup_step2.dart';
import 'package:app_cargo/screens/signup/signup_controller.dart';
import 'package:app_cargo/screens/signup/signup_step3.dart';
import 'package:app_cargo/screens/signup/signup_step4.dart';
import 'package:app_cargo/widgets/app_confirm_popup.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  final FacebookAppEvents _facebookAppEvents =
      DIContainer().get<FacebookAppEvents>();

  final FirebaseAnalytics firebaseAnalytics =
      DIContainer().get<FirebaseAnalytics>();

  final List<SignUpStep> _signUpSteps = <SignUpStep>[
    SignUpStep1(),
    SignUpStep2(),
    SignUpStep3(),
    // SignUpStep4()
  ];

  Widget _buildBody(BuildContext context) {
    return Consumer<SignUpModel>(
      builder: (context, signUpProgressModel, _) {
        SignUpStep currentStep = _signUpSteps[signUpProgressModel._step];
        Widget stepContent = currentStep.build(context);

        return Column(
          children: <Widget>[
            Container(
                child: Stack(
              children: <Widget>[
                Container(
                  height: 180,
                  child: Image(
                    image: AssetImage('assets/images/ic_header.png'),
                    fit: BoxFit.cover,
                  ),
                ),
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    child: FittedBox(
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: 1, minHeight: 1),
                        child: Image.asset(
                          "assets/images/logo.png",
                          height: 70,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
//            SizedBox(height: 12),
//             LinearPercentIndicator(
//               lineHeight: 10.0,
//               percent: signUpProgressModel.completionPercentage,
//               progressColor: AppColors.blue,
//               alignment: MainAxisAlignment.spaceBetween,
//               linearStrokeCap: LinearStrokeCap.butt,
//               padding: EdgeInsets.all(0),
//             ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: stepContent,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignUpModel>(
          create: (_) => SignUpModel(_signUpSteps.length),
        ),
        ChangeNotifierProvider<SignUpController>(
          create: (_) => SignUpController(),
        ),
      ],
      child: Consumer<SignUpModel>(
        builder: (context, signUpModel, _) => AppScaffold(
          horizontalPadding: 0,
          verticalPadding: 0,
          title: AppLocalization.of(context).alertNewAccount,
          showAppBar: false,
          showMenu: false,
          implyLeading: false,
          showBackground: false,
          willPopCallback: () {
            if (signUpModel.canDecrement) {
              signUpModel.decrementStep();
              return Future.value(false);
            } else {
              return showAppConfirmPopup(
                context,
                "Atenção",
                "Tem certeza de que deseja desistir do cadastro?",
                "Continuar meu cadastro",
                () {
                  Navigator.of(context).pop(false);
                },
                cancelOptionTitle: "Sim, quero desistir",
                onCancel: () {
                  _facebookAppEvents.clearUserData();
                  _facebookAppEvents.clearUserID();
                  Navigator.of(context).pop(true);
                },
              );
            }
          },
          body: _buildBody(context),
        ),
      ),
    );
  }
}

class SignUpModel with ChangeNotifier {
  int _step = 0;
  final int _maxStep;

  SignUpModel(this._maxStep);

  int get step => _step;

  double get completionPercentage => (_step + 1) / _maxStep;

  bool get finished => _step == _maxStep;

  bool get canDecrement => _step > 0;

  bool get canIncrement => _step < _maxStep - 1;

  void incrementStep() {
    if (canIncrement) {
      _step++;
      notifyListeners();
    }
  }

  void decrementStep() {
    if (canDecrement) {
      _step--;
      notifyListeners();
    }
  }
}

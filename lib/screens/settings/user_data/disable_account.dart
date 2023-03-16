import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/constants/analytics_events_constants.dart';

import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/widgets/app_action_button.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../../routes.dart';

class DisableAccount extends StatelessWidget {
  final FacebookAppEvents _facebookAppEvents =
      DIContainer().get<FacebookAppEvents>();

  final FirebaseAnalytics _firebaseAnalytics =
      DIContainer().get<FirebaseAnalytics>();

  @override
  Widget build(BuildContext context) {

    return AppScaffold(
      title: "CONFIGURAÇÕES",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
            child: SkyText(
              "Desativar a conta",
              textAlign: TextAlign.justify,
              textColor: AppColors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: AppColors.white,
            ),
            padding: EdgeInsets.symmetric(
                vertical: Dimen.horizontal_padding,
                horizontal: Dimen.horizontal_padding),
            child: Column(
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
                  child: SkyText(
                    "Você tem certeza que deseja desativar a sua conta? O AppCargo é um aplicativo criado para você, motorista. Há alguma coisa que podemos fazer por você? Por favor, entre em contato caso possamos te ajudar.",
                    textAlign: TextAlign.justify,
                    textColor: AppColors.green,
                    fontSize: 18,
                  ),
                ),
                AppSaveButton(
                  "QUERO MANTER A CONTA",
                  onPressed: () {
                    Navigator.popAndPushNamed(
                        context, Routes.settingsPersonalData);
                  },
                ),
                AppActionButton(
                  "QUERO DESATIVAR",
                  fontSize: 17,
                  onPressed: () {
                    _facebookAppEvents.logEvent(
                        name: AnalyticsEventsConstants.accountDisabled,
                        parameters: {
                          AnalyticsEventsConstants.action: AnalyticsEventsConstants.buttonClick
                        });
                    _firebaseAnalytics.logEvent(
                        name: AnalyticsEventsConstants.accountDisabled,
                        parameters: {
                          AnalyticsEventsConstants.action: AnalyticsEventsConstants.buttonClick
                        });
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.disabledAccount,
                        (Route<dynamic> route) => false);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

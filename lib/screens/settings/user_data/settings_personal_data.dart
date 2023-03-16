import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/constants/analytics_events_constants.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../../routes.dart';

class SettingsPersonalData extends StatelessWidget {
  final FacebookAppEvents _facebookAppEvents = DIContainer().get<FacebookAppEvents>();
  final FirebaseAnalytics _firebaseAnalytics = DIContainer().get<FirebaseAnalytics>();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "CONFIGURAÇÕES",
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
              child: SkyButton(
                  textColor: AppColors.blue,
                  inlineIcon: Icon(
                    Icons.perm_contact_calendar,
                    size: 30,
                    color: AppColors.yellow,
                  ),
                  text: "SEUS DADOS",
                  fontSize: 25,
                  borderRadius: 10,
                  buttonColor: AppColors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.settingsYourData);
                  }),
            ),
            Container(
              width: 666,
              padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
              child: SkyButton(
                textColor: AppColors.blue,
                inlineIcon: Icon(
                  Icons.local_shipping,
                  size: 30,
                  color: AppColors.yellow,
                ),
                text: "DADOS DO VEICULO",
                fontSize: 25,
                borderRadius: 10,
                buttonColor: AppColors.white,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.settingsVehicleData);
                },
              ),
            ),
            Container(
              width: 666,
              padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
              child: SkyButton(
                textColor: AppColors.blue,
                inlineIcon: Icon(
                  Icons.home,
                  size: 30,
                  color: AppColors.yellow,
                ),
                text: "DADOS DE CONTATO",
                fontSize: 25,
                borderRadius: 10,
                buttonColor: AppColors.white,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.settingsContactData);
                },
              ),
            ),/*
            Container(
              width: 666,
              padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
              child: SkyButton(
                textColor: AppColors.blue,
                inlineIcon: Icon(
                  Icons.credit_card,
                  size: 25,
                  color: AppColors.yellow,
                ),
                text: "PAGAMENTO",
                fontSize: 25,
                borderRadius: 10,
                buttonColor: AppColors.white,
                onPressed: () {
//                  Navigator.pushNamed(context, Routes.settingsPayment);
                },
              ),
            ),*/
            Container(
              width: 666,
              padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
              child: SkyButton(
                textColor: AppColors.blue,
                inlineIcon: Icon(
                  Icons.lock,
                  size: 25,
                  color: AppColors.yellow,
                ),
                text: "TROCAR SENHA",
                fontSize: 25,
                borderRadius: 10,
                buttonColor: AppColors.white,
                onPressed: () {
                  Navigator.pushNamed(
                      context, Routes.settingsChangePasswordData);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 180),
              width: 666,
              child: SkyButton(
                buttonColor: AppColors.white,
                borderRadius: 10,
                text: "Desativar a conta",
                borderColor: AppColors.blue,
                textColor: AppColors.blue,
                fontSize: 25,
                onPressed: () {

                  _facebookAppEvents.logEvent(
                      name: AnalyticsEventsConstants.disabled,
                      parameters: {
                        AnalyticsEventsConstants.action:
                        AnalyticsEventsConstants.buttonClick
                      });
                  _firebaseAnalytics.logEvent(
                      name: AnalyticsEventsConstants.disabled,
                      parameters: {
                        AnalyticsEventsConstants.action:
                        AnalyticsEventsConstants.buttonClick
                      });
                  Navigator.pushNamed(context, Routes.disableAccount);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/constants/analytics_events_constants.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../routes.dart';

class SettingsMenu extends StatelessWidget {

  final FacebookAppEvents _facebookAppEvents = DIContainer().get<FacebookAppEvents>();
  final FirebaseAnalytics _firebaseAnalytics = DIContainer().get<FirebaseAnalytics>();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "CONFIGURAÇÕES",
      body: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding:
                  EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
                  child: SkyButton(
                    textColor: AppColors.blue,
                    inlineIcon: Icon(
                      Icons.person,
                      size: 30,
                      color: AppColors.yellow,
                    ),
                    text: "DADOS PESSOAIS",
                    fontSize: 25,
                    borderRadius: 10,
                    buttonColor: AppColors.white,
                    onPressed: () {

                      _facebookAppEvents.logEvent(
                          name: AnalyticsEventsConstants.userSettings,
                          parameters: {
                            AnalyticsEventsConstants.action: AnalyticsEventsConstants.viewEntrance
                          });
                      _firebaseAnalytics.logEvent(
                          name: AnalyticsEventsConstants.userSettings,
                          parameters: {
                            AnalyticsEventsConstants.action: AnalyticsEventsConstants.viewEntrance
                          });

                      Navigator.pushNamed(context, Routes.settingsPersonalData);
                    },
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
                  child: SkyButton(
                    textColor: AppColors.blue,
                    inlineIcon: Icon(
                      Icons.notifications,
                      size: 30,
                      color: AppColors.yellow,
                    ),
                    text: "NOTIFICAÇÕES",
                    fontSize: 25,
                    borderRadius: 10,
                    buttonColor: AppColors.white,
                    onPressed: () {
                      Navigator.pushNamed(
                          context, Routes.settingsNotifications);
                    },
                  ),
                ),
//                Container(
//                  padding:
//                      EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
//                  child: SkyButton(
//                    textColor: AppColors.blue,
//                    inlineIcon: Icon(
//                      Icons.message,
//                      size: 30,
//                      color: AppColors.yellow,
//                    ),
//                    text: " RECLAMAÇÕES",
//                    fontSize: 25,
//                    borderRadius: 10,
//                    buttonColor: AppColors.white,
//                    onPressed: () {
//                      Navigator.pushNamed(context, Routes.settingsComplaint);
//                    },
//                  ),
//                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
                  child: SkyButton(
                    textColor: AppColors.blue,
                    inlineIcon: Icon(
                      Icons.help,
                      size: 30,
                      color: AppColors.yellow,
                    ),
                    text: "AJUDA",
                    fontSize: 25,
                    borderRadius: 10,
                    buttonColor: AppColors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.settingsHelpMenu);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

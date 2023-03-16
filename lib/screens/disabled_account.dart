import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/constants/analytics_events_constants.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:app_cargo/widgets/app_action_button.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../routes.dart';

class DisabledAccount extends StatelessWidget {
  final FacebookAppEvents _facebookAppEvents =
      DIContainer().get<FacebookAppEvents>();

  final FirebaseAnalytics _firebaseAnalytics =
      DIContainer().get<FirebaseAnalytics>();

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
                    "CONTA DESATIVADA",
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
                            "É uma pena! Esperamos que você volte em breve!",
                            textColor: AppColors.green,
                            textAlign: TextAlign.center,
                            fontSize: 18,
                          )),
                      AppSaveButton(
                        "QUERO REATIVAR",
                        onPressed: () {
                          _facebookAppEvents.logEvent(
                              name: AnalyticsEventsConstants.accountReactivated,
                              parameters: {
                                AnalyticsEventsConstants.action:
                                    AnalyticsEventsConstants.buttonClick
                              });
                          _firebaseAnalytics.logEvent(
                              name: AnalyticsEventsConstants.accountReactivated,
                              parameters: {
                                AnalyticsEventsConstants.action:
                                    AnalyticsEventsConstants.buttonClick
                              });
                          Navigator.pushNamed(context, Routes.menu);
                        },
                      ),
                      AppActionButton(
                        "SAIR",
                        onPressed: () {
                          /// Envio de um Token vazio para forçar o login novamente.
                          final ConfigurationService configService =
                              DIContainer().get<ConfigurationService>();
                          configService.setAccessToken('');

                          Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.index,
                            (Route<dynamic> route) => false,
                          );
                        },
                      ),
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

import 'dart:math';

import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';
import 'package:flutter_skywalker_core/src/widgets/sky_button.dart';
import 'package:flutter_skywalker_core/src/widgets/sky_text.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:app_cargo/constants/analytics_events_constants.dart';
import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/constants/endpoints.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/i18n/localization.dart';
import 'package:app_cargo/routes.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:app_cargo/widgets/app_confirm_popup.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/app_text_button.dart';

class StartScreen extends StatefulWidget {
  final ConfigurationService configurationService =
      DIContainer().get<ConfigurationService>();

  @override
  State<StatefulWidget> createState() =>
      _StartScreenState(configurationService);
}

class _StartScreenState extends State<StartScreen> {
  final ConfigurationService configurationService;
  Future<String> _accessTokenFuture;

  FacebookAppEvents _facebookAppEvents = DIContainer().get<FacebookAppEvents>();
  FirebaseAnalytics _firebaseAnalytics = DIContainer().get<FirebaseAnalytics>();
  bool _firstLoaded = false;

  void initState() {
    _accessTokenFuture = configurationService.accessToken.then((value) {
      if (value != null) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.index,
          (Route<dynamic> route) => false,
        );
      }
      return value;
    });
    _facebookAppEvents.setAutoLogAppEventsEnabled(true);
    super.initState();
  }

  _StartScreenState(this.configurationService);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: false,
      body: Container(
        padding: EdgeInsets.only(
          left: Dimen.horizontal_padding,
          right: Dimen.horizontal_padding,
          top: MediaQuery.of(context).padding.top,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: _accessTokenFuture,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    return Column(
                      children: <Widget>[
                        Container(
                          height: 190,
                          width: 666,
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 1,
                                minHeight: 1,
                              ), // here
                              child: Image.asset(
                                "assets/images/logo.png",
                                height: 140,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SkyText(
                              "BEM-VINDO",
                              fontSize: 40,
                              textColor: AppColors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: 110,
                          width: 250,
                          padding: EdgeInsets.symmetric(
                              vertical: Dimen.horizontal_padding),
                          child: SkyButton(
                            text: "TENHO\nCADASTRO",
                            onPressed: () {
                              _facebookAppEvents.logEvent(
                                  name: AnalyticsEventsConstants.signin,
                                  parameters: {
                                    AnalyticsEventsConstants.action:
                                        AnalyticsEventsConstants.viewEntrance
                                  });
                              _firebaseAnalytics.logEvent(
                                  name: AnalyticsEventsConstants.signin,
                                  parameters: {
                                    AnalyticsEventsConstants.action:
                                        AnalyticsEventsConstants.viewEntrance
                                  });

                              Navigator.pushNamed(context, Routes.signIn);
                            },
                            fontSize: 30,
                            borderRadius: 15,
                            textColor: AppColors.white,
                            buttonColor: AppColors.green,
                            fontWeight: FontWeight.normal,
                            maxLines: 2,
                          ),
                        ),
                        Container(
                          height: 110,
                          width: 250,
                          padding: EdgeInsets.symmetric(
                              vertical: Dimen.horizontal_padding),
                          child: SkyButton(
                            text: "QUERO ME\nCADASTRAR",
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.signUp);
                            },
                            fontSize: 30,
                            borderRadius: 15,
                            textColor: AppColors.white,
                            buttonColor: AppColors.blue,
                            fontWeight: FontWeight.normal,
                            maxLines: 2,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 55),
                          child: Container(
                            height: 30,
                            width: 250,
                            child: SkyButton(
                              text: "SOU DA TRANSPORTADORA",
                              onPressed: _openAppCargoWebsite,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              buttonColor: AppColors.yellow,
                              borderRadius: 50,
                              textColor: AppColors.white,
                            ),
                          ),
                        ),
                        AppTextButton(
                          "Termos e condições de uso",
                          onClick: () async {
                            if (await canLaunch(Endpoints.termsOfUse)) {
                              await launch(Endpoints.termsOfUse);
                            } else {
                              // TODO: VISUAL FEEDBACK ON NOT BEING ABLE TO LAUNCH THE PDF
                            }
                          },
                        ),
                        AppTextButton(
                          "Política de privacidade",
                          onClick: () async {
                            if (await canLaunch(Endpoints.policyPrivacyUrl)) {
                              await launch(Endpoints.policyPrivacyUrl);
                            } else {
                              // TODO: VISUAL FEEDBACK ON NOT BEING ABLE TO LAUNCH THE PDF
                            }
                          },
                        ),
                      ],
                    );
                    break;
                  default:
                    return AppLoadingWidget();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _goToSignUp(BuildContext context) {
    showAppConfirmPopup(
      context,
      AppLocalization.of(context).alertNewAccount,
      AppLocalization.of(context).alertNewAccountDescription,
      AppLocalization.of(context).actionWannaSignUp,
      () {
        // Close the BottomSheet and navigate to SignUp
        String rndUID = Random.secure().nextInt(1000).toString();
        _facebookAppEvents.setUserID(rndUID);
        _facebookAppEvents
            .logEvent(name: AnalyticsEventsConstants.signup, parameters: {
          AnalyticsEventsConstants.action: AnalyticsEventsConstants.viewEntrance
        });

        _firebaseAnalytics
            .logEvent(name: AnalyticsEventsConstants.signup, parameters: {
          AnalyticsEventsConstants.action: AnalyticsEventsConstants.viewEntrance
        });
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

  void _openAppCargoWebsite() async {
    launch(Endpoints.appWebsite);
  }
}

import 'package:app_cargo/constants/analytics_events_constants.dart';
import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/notification_configuration/notification_configuration.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/app_switch_settings.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../../routes.dart';

part 'settings_notification_controller.dart';

class SettingsNotifications extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsNotifications();
}

class _SettingsNotifications extends State<SettingsNotifications> {
  final ConfigurationService _configurationService =
      DIContainer().get<ConfigurationService>();
  SettingsNotificationController _notificationController;
  Future _loaded;

  final FacebookAppEvents _facebookAppEvents =
      DIContainer().get<FacebookAppEvents>();
  final FirebaseAnalytics _firebaseAnalytics =
      DIContainer().get<FirebaseAnalytics>();

  bool initialStateNotifyNearbyRequestsForAnalytics;
  bool initialStateNotifyCompanyContactForAnalytics;
  bool initialStateNotifyCargoClubOffersForAnalytics;
  bool initialStateNotifyNewRequestsForAnalytics;

  void initState() {
    super.initState();

    _firebaseAnalytics.logEvent(
        name: AnalyticsEventsConstants.notificationsSettings,
        parameters: {
          AnalyticsEventsConstants.action: AnalyticsEventsConstants.viewEntrance
        });
    _facebookAppEvents.logEvent(
        name: AnalyticsEventsConstants.notificationsSettings,
        parameters: {
          AnalyticsEventsConstants.action: AnalyticsEventsConstants.viewEntrance
        });

    _loaded = _configurationService
        .getAllNotificationConfiguration()
        .then((NotificationConfiguration notificationConfiguration) {
      _notificationController =
          new SettingsNotificationController(notificationConfiguration);

      initialStateNotifyNearbyRequestsForAnalytics =
          _notificationController.notifyNearbyRequests;
      initialStateNotifyCompanyContactForAnalytics =
          _notificationController.notifyCompanyContact;
      initialStateNotifyCargoClubOffersForAnalytics =
          _notificationController.notifyCargoClubOffers;
      initialStateNotifyNewRequestsForAnalytics =
          _notificationController.notifyNewRequests;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loaded,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return _buildBody(context);
            break;
          default:
            return AppLoadingWidget();
        }
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return AppScaffold(
      title: "CONFIGURAÇÕES",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimen.vertical_padding,
                            horizontal: Dimen.horizontal_padding - 5),
                        child: Icon(
                          Icons.notifications,
                          size: 25,
                          color: AppColors.blue,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimen.vertical_padding,
                            horizontal: Dimen.horizontal_padding - 5),
                        child: SkyText(
                          "NOTIFICAÇOES",
                          fontSize: 25,
                          textColor: AppColors.blue,
                        ),
                      )
                    ],
                  ),
                ),
                AppSwitchSetting(
                  description: "Receber notificações de fretes próximos a você",
                  descriptionColor: AppColors.light_blue,
                  descriptionSize: 16,
                  enable: _notificationController.notifyNearbyRequests,
                  title: "Alerta de fretes próximos",
                  titleColor: AppColors.blue,
                  titleSize: 18,
                  onChanged: (value) {
                    _notificationController.notifyNearbyRequests = value;
                  },
                ),
                AppSwitchSetting(
                  description:
                      "Receber notificações em casos de contatos das transportadoras",
                  descriptionColor: AppColors.light_blue,
                  descriptionSize: 16,
                  enable: _notificationController.notifyCompanyContact,
                  title: "Alerta de contato com companhias",
                  titleColor: AppColors.blue,
                  titleSize: 18,
                  onChanged: (value) {
                    _notificationController.notifyCompanyContact = value;
                  },
                ),
                AppSwitchSetting(
                  description:
                      "Receber notificação de novas propostas de fretes",
                  descriptionColor: AppColors.light_blue,
                  descriptionSize: 16,
                  enable: _notificationController.notifyNewRequests,
                  title: "Alerta de novos fretes",
                  titleColor: AppColors.blue,
                  titleSize: 18,
                  onChanged: (value) {
                    _notificationController.notifyNewRequests = value;
                  },
                ),
                AppSwitchSetting(
                  description:
                      "Receber notificações de cupons do clube de ofertas",
                  descriptionColor: AppColors.light_blue,
                  descriptionSize: 16,
                  enable: _notificationController.notifyCargoClubOffers,
                  title: "Alerta do clube de ofertas",
                  titleColor: AppColors.blue,
                  titleSize: 18,
                  onChanged: (value) {
                    _notificationController.notifyCargoClubOffers = value;
                  },
                ),
                AppSaveButton(
                  "SALVAR",
                  onPressed: () {
                    sendEventToAnalytics();

                    print(NotificationConfiguration.toJson(
                        _notificationController
                            .getNotificationConfiguration()));
                    showLoadingThenOkDialog(
                        context,
                        _configurationService.updateNotificationConfiguration(
                            _notificationController
                                .getNotificationConfiguration()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void sendEventToAnalytics() {
    if (initialStateNotifyNearbyRequestsForAnalytics !=
        _notificationController.notifyNearbyRequests) {
      if (_notificationController.notifyNearbyRequests) {

        _facebookAppEvents.logEvent(
            name: AnalyticsEventsConstants.enableNearFreightNotificationAlert);
        _firebaseAnalytics.logEvent(
            name: AnalyticsEventsConstants.enableNearFreightNotificationAlert);
      } else {
        _facebookAppEvents.logEvent(
            name: AnalyticsEventsConstants.disableNearFreightNotificationAlert);
        _firebaseAnalytics.logEvent(
            name: AnalyticsEventsConstants.disableNearFreightNotificationAlert);
      }
    }

    if (initialStateNotifyCompanyContactForAnalytics !=
        _notificationController.notifyCompanyContact) {
      if (_notificationController.notifyCompanyContact) {
        _facebookAppEvents.logEvent(
            name: AnalyticsEventsConstants
                .enableCompaniesContactNotificationAlert);
        _firebaseAnalytics.logEvent(
            name: AnalyticsEventsConstants
                .enableCompaniesContactNotificationAlert);
      } else {
        _facebookAppEvents.logEvent(
            name: AnalyticsEventsConstants
                .disableCompaniesContactNotificationAlert);
        _firebaseAnalytics.logEvent(
            name: AnalyticsEventsConstants
                .disableCompaniesContactNotificationAlert);
      }
    }

    if (initialStateNotifyCargoClubOffersForAnalytics !=
        _notificationController.notifyCargoClubOffers) {
      if (_notificationController.notifyCargoClubOffers) {
        _facebookAppEvents.logEvent(
            name: AnalyticsEventsConstants.enableDiscountClubNotificationAlert);
        _firebaseAnalytics.logEvent(
            name: AnalyticsEventsConstants.enableDiscountClubNotificationAlert);
      } else {
        _facebookAppEvents.logEvent(
            name:
                AnalyticsEventsConstants.disableDiscountClubNotificationAlert);
        _firebaseAnalytics.logEvent(
            name:
                AnalyticsEventsConstants.disableDiscountClubNotificationAlert);
      }
    }

    if (initialStateNotifyNewRequestsForAnalytics !=
        _notificationController.notifyNewRequests) {
      if (_notificationController.notifyNewRequests) {
        _facebookAppEvents.logEvent(
            name: AnalyticsEventsConstants.enableNewFreightNotificationAlert);
        _firebaseAnalytics.logEvent(
            name: AnalyticsEventsConstants.enableNewFreightNotificationAlert);
      } else {
        _facebookAppEvents.logEvent(
            name: AnalyticsEventsConstants.disableNewFreightNotificationAlert);
        _firebaseAnalytics.logEvent(
            name: AnalyticsEventsConstants.disableNewFreightNotificationAlert);
      }
    }
  }
}

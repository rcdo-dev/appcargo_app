import 'package:app_cargo/constants/analytics_events_constants.dart';
import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/truck_data/change_truck_status.dart';
import 'package:app_cargo/screens/cargo/receive_freight.dart';
import 'package:app_cargo/services/freight/freight_service.dart';
import 'package:app_cargo/services/me/me_service.dart';
import 'package:app_cargo/widgets/app_action_button.dart';
import 'package:app_cargo/widgets/app_confirm_popup.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../routes.dart';

class CargoMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CargoMenuState();
}

class _CargoMenuState extends State<CargoMenu> {
  final MeService _meService = DIContainer().get<MeService>();
  final FreightService _freightService = DIContainer().get<FreightService>();
  Widget _truckStatusButtons;
  Future _loaded;

  FacebookAppEvents _facebookAppEvents = DIContainer().get<FacebookAppEvents>();
  FirebaseAnalytics _firebaseAnalytics = DIContainer().get<FirebaseAnalytics>();

  @override
  void initState() {
    super.initState();
    _loaded = _freightService.getCurrentFreight().then((freightDetails) {
      if (freightDetails == null)
        _buildTruckStatusButtons();
      else
        _buildAlreadyWithCurrentFreightInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "CARGAS",
      body: Container(
        padding: EdgeInsets.all(Dimen.horizontal_padding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.symmetric(vertical: Dimen.vertical_padding + 15),
              child: SkyText(
                "VAMOS ATUALIZAR SEU STATUS DE CARGA?",
                textColor: AppColors.green,
                textAlign: TextAlign.center,
                fontSize: 25,
              ),
            ),
            FutureBuilder(
              future: _loaded,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    return _truckStatusButtons;
                    break;
                  default:
                    return AppLoadingWidget();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void _buildAlreadyWithCurrentFreightInfo() {
    _truckStatusButtons = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: SkyText(
            "Você já possui um frete do AppCargo em andamento, a situação do frete é atualizada pela trasnportadora",
            textColor: AppColors.blue,
            textAlign: TextAlign.justify,
            fontSize: 17,
          ),
        )
      ],
    );
  }

  void _buildTruckStatusButtons() {
    _truckStatusButtons = Column(
      children: <Widget>[
        // TODO: Change the actual ICONS for the ICONS from ARCADIA
        Container(
          padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding + 15),
          child: SkyText(
            "MEU CAMINHÃO ESTÁ: ",
            textColor: AppColors.blue,
            textAlign: TextAlign.center,
            fontSize: 25,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
          child: AppActionButton(
            "COM CARGA",
            textColor: AppColors.blue,
            inlineIcon: Icon(
              Icons.widgets,
              color: AppColors.yellow,
              size: 30,
            ),
            cupertinoHeightButton: 80,
            fontSize: 22,
            onPressed: () {
              Navigator.pushNamed(context, Routes.withCargo);
            },
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
          child: AppActionButton(
            "DESCARREGANDO",
            textColor: AppColors.blue,
            inlineIcon: Icon(
              Icons.widgets,
              color: AppColors.yellow,
              size: 30,
            ),
            cupertinoHeightButton: 80,
            fontSize: 22,
            onPressed: () {
              showAppConfirmPopup(
                context,
                "Descarregando",
                "Gostaria de receber mais fretes?",
                "SIM",
                () {
                  Navigator.pop(context);
                  showLoadingThenOkDialog(
                    context,
                    _meService.updateTruckStatus(
                      ChangeTruckStatus(
                        status: TruckStatus.UNLOADING,
                        data: ChangeTruckStatusData(notifyNewRequests: true),
                      ),
                    ),
                  ).then(
                    (value) {
                      _firebaseAnalytics.logEvent(
                          name: AnalyticsEventsConstants
                              .enableFreightNotifications,
                          parameters: {
                            AnalyticsEventsConstants.action:
                            AnalyticsEventsConstants.enableFreights
                          });

                      _facebookAppEvents.logEvent(
                          name: AnalyticsEventsConstants
                              .enableFreightNotifications,
                          parameters: {
                            AnalyticsEventsConstants.action:
                            AnalyticsEventsConstants.enableFreights
                          });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReceiveFreight(
                            meService: _meService,
                            status: TruckStatus.UNLOADING,
                          ),
                        ),
                      );
                    },
                  );
                },
                cancelOptionTitle: "NAO",
                onCancel: () {
                  Navigator.pop(context);
                  showLoadingThenOkDialog(
                    context,
                    _meService.updateTruckStatus(
                      ChangeTruckStatus(
                        status: TruckStatus.UNLOADING,
                        data: ChangeTruckStatusData(notifyNewRequests: false),
                      ),
                    ),
                  ).then(
                    (value) {
                      _firebaseAnalytics.logEvent(
                          name: AnalyticsEventsConstants
                              .disableFreightNotifications,
                          parameters: {
                            AnalyticsEventsConstants.action:
                                AnalyticsEventsConstants.disableFreights
                          });

                      _facebookAppEvents.logEvent(
                          name: AnalyticsEventsConstants
                              .disableFreightNotifications,
                          parameters: {
                            AnalyticsEventsConstants.action:
                                AnalyticsEventsConstants.disableFreights
                          });
                      showMessageDialog(context,
                          message:
                              "Você desativou as notificações de frete! Para reativá-las altera suas configurações de notificação.");
                    },
                  );
                },
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
          child: AppActionButton(
            "SEM CARGA",
            textColor: AppColors.blue,
            inlineIcon: Icon(
              Icons.widgets,
              color: AppColors.yellow,
              size: 30,
            ),
            cupertinoHeightButton: 80,
            fontSize: 22,
            onPressed: () {
              showAppConfirmPopup(
                context,
                "Sem carga",
                "Gostaria de receber mais fretes?",
                "SIM",
                () {
                  Navigator.pop(context);
                  showLoadingThenOkDialog(
                    context,
                    _meService.updateTruckStatus(
                      ChangeTruckStatus(
                        status: TruckStatus.AVAILABLE,
                        data: ChangeTruckStatusData(notifyNewRequests: true),
                      ),
                    ),
                  ).then(
                    (value) {
                      _firebaseAnalytics.logEvent(
                          name: AnalyticsEventsConstants
                              .enableFreightNotifications,
                          parameters: {
                            AnalyticsEventsConstants.action:
                                AnalyticsEventsConstants.enableFreights
                          });

                      _facebookAppEvents.logEvent(
                          name: AnalyticsEventsConstants
                              .enableFreightNotifications,
                          parameters: {
                            AnalyticsEventsConstants.action:
                                AnalyticsEventsConstants.enableFreights
                          });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReceiveFreight(
                            meService: _meService,
                            status: TruckStatus.AVAILABLE,
                          ),
                        ),
                      );
                    },
                  );
                },
                cancelOptionTitle: "NAO",
                onCancel: () {
                  Navigator.pop(context);
                  showLoadingThenOkDialog(
                    context,
                    _meService.updateTruckStatus(
                      ChangeTruckStatus(
                        status: TruckStatus.AVAILABLE,
                        data: ChangeTruckStatusData(notifyNewRequests: false),
                      ),
                    ),
                  ).then(
                    (value) {
                      _firebaseAnalytics.logEvent(
                          name: AnalyticsEventsConstants
                              .disableFreightNotifications,
                          parameters: {
                            AnalyticsEventsConstants.action:
                            AnalyticsEventsConstants.disableFreights
                          });

                      _facebookAppEvents.logEvent(
                          name: AnalyticsEventsConstants
                              .disableFreightNotifications,
                          parameters: {
                            AnalyticsEventsConstants.action:
                            AnalyticsEventsConstants.disableFreights
                          });
                      showMessageDialog(context,
                          message:
                              "Você desativou as notificações de frete! Para reativá-las altera suas configurações de notificação.");
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

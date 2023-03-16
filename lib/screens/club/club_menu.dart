import 'dart:io';

import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/endpoints.dart';
import 'package:app_cargo/constants/analytics_events_constants.dart';

import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/club_banner/club_partner.dart';
import 'package:app_cargo/screens/club/widget/app_club_banner.dart';
import 'package:app_cargo/services/club_banner/club_banner_service.dart';
import 'package:app_cargo/widgets/app_action_button.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/app_partner_card.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/pageable_list_view.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../constants/app_colors.dart';
import '../../routes.dart';

class ClubMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClubMenuState();
}

class _ClubMenuState extends State<ClubMenu> {
  final ClubBannerService _clubBannerService =
      DIContainer().get<ClubBannerService>();

  final FacebookAppEvents _facebookAppEvents =
      DIContainer().get<FacebookAppEvents>();

  List<ClubPartner> _partnerList = new List<ClubPartner>();

  Future _loaded;
  bool firstPresentation = false;

  FirebaseAnalytics _firebaseAnalytics = DIContainer().get<FirebaseAnalytics>();

  @override
  void initState() {
    _firebaseAnalytics.setCurrentScreen(screenName: Routes.clubMenu);
    super.initState();
    _loaded = _clubBannerService.getPartners().then((listPartner) {
      if (listPartner == null) {
        return;
      } else {
        return _partnerList.addAll(listPartner);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "CARGO SHOP",
      scrollable: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background/fundo2@3x.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder(
            future: _loaded,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return _partnerList.isEmpty
                      ? Center(
                          child: Text(
                            "Sem parceiros no momento. Volte em breve.",
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount:
                              _partnerList.isEmpty ? 0 : _partnerList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: <Widget>[
                                  index == 0
                                      ? Container(
                                          height: 100,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 40, vertical: 10),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/partner.jpg"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  GestureDetector(
                                    onTap: () {
                                      _facebookAppEvents.logEvent(
                                          name: AnalyticsEventsConstants
                                              .partnerBanner,
                                          parameters: {
                                            AnalyticsEventsConstants.action:
                                                AnalyticsEventsConstants
                                                    .buttonClick
                                          });
                                      _firebaseAnalytics.logEvent(
                                          name: AnalyticsEventsConstants
                                              .partnerBanner,
                                          parameters: {
                                            AnalyticsEventsConstants.action:
                                                AnalyticsEventsConstants
                                                    .buttonClick
                                          });

                                      _facebookAppEvents.logViewContent(
                                          id: _partnerList[index].hash,
                                          content: ClubPartner.toJson(
                                              _partnerList[index]),
                                          type: AnalyticsEventsConstants
                                              .partnerBanner);

                                      _firebaseAnalytics.logViewItem(
                                          itemId: _partnerList[index].hash,
                                          itemName: _partnerList[index].name,
                                          itemCategory:
                                              _partnerList[index].description);

                                      goToPartnerBannerList(
                                          context, _partnerList[index].hash);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              9 /
                                              16,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            Endpoints.baseUrl +
                                                _partnerList[index].photo,
                                          ),
                                        ),
                                        borderRadius: new BorderRadius.all(
                                            Radius.circular(25)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 23),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            _partnerList[index].name,
                                            style: TextStyle(
                                                color: AppColors.dark_green,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            _partnerList[index].description ==
                                                        null ||
                                                    _partnerList[index]
                                                            .description ==
                                                        ""
                                                ? ""
                                                : _partnerList[index]
                                                    .description,
                                            style: TextStyle(
                                                color: AppColors.dark_green),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                  break;

                default:
                  return AppLoadingWidget();
              }
            }),
      ),
    );
  }

  String getFormattedBannerQuantity(int bannerQty) {
    if (null == bannerQty || 0 == bannerQty) return null;
    if (1 == bannerQty) return "VER OFERTA";
    return "VER ($bannerQty) OFERTAS";
  }

  void goToPartnerBannerList(BuildContext ctx, String hash) {
    Navigator.pushNamed(ctx, Routes.clubPartnerDetails, arguments: {
      'partnerHash': hash,
      'partnerName': hash,
    });
  }
}

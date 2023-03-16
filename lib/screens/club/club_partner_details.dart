import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/endpoints.dart';
import 'package:app_cargo/constants/analytics_events_constants.dart';
import 'package:app_cargo/domain/club_banner/partner_banners.dart';
import 'package:app_cargo/domain/partner_event_analytics/partner_event_analytics.dart';
import 'package:app_cargo/services/club_banner/club_banner_service.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../di/container.dart';
import '../../widgets/app_scaffold.dart';

class ClubPartnerDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClubPartnerDetailsState();
}

class _ClubPartnerDetailsState extends State<ClubPartnerDetails> {
  final ClubBannerService _clubBannerService = DIContainer().get<ClubBannerService>();

  final FacebookAppEvents _facebookAppEvents = DIContainer().get<FacebookAppEvents>();
  final FirebaseAnalytics _firebaseAnalytics = DIContainer().get<FirebaseAnalytics>();

  PartnerBanners _partnerBanners;

  Future _loaded;
  bool hasLoaded = false;
  int _currentPositionBanner = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    final String partnerHash = args['partnerHash'];

    final size = MediaQuery.of(context).size;

    if (!hasLoaded) {
      _loaded = _clubBannerService.getBannersByPartner(partnerHash).then(
        (partnerBanners) {
          hasLoaded = true;
          if (null != partnerBanners) {
            _partnerBanners = partnerBanners;
          }
        },
      );
    }

    return AppScaffold(
      title: 'CLUBE CARGO',
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: _loaded,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    if (_partnerBanners.banners.isNotEmpty) {
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            height: size.height / 14,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  Endpoints.baseUrl + _partnerBanners.partner.logoToShowOnAppBannersPage,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _partnerBanners.banners.map((element) {
                              int index = _partnerBanners.banners.indexOf(element);
                              return Container(
                                height: 8,
                                width: 8,
                                margin: EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 2.0,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.green,
                                  ),
                                  shape: BoxShape.circle,
                                  color: _currentPositionBanner == index ? AppColors.green : AppColors.white,
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          CarouselSlider(
                            options: CarouselOptions(
                              height: size.height / 1.5,
                              viewportFraction: 0.9,
                              enlargeCenterPage: false,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentPositionBanner = index;
                                });
                              },
                            ),
                            items: _partnerBanners.banners.map(
                              (element) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      _facebookAppEvents.logEvent(
                                        name: AnalyticsEventsConstants.openDiscount,
                                        parameters: {AnalyticsEventsConstants.action: AnalyticsEventsConstants.buttonClick},
                                      );
                                      _firebaseAnalytics.logEvent(
                                        name: AnalyticsEventsConstants.openDiscount,
                                        parameters: {AnalyticsEventsConstants.action: AnalyticsEventsConstants.buttonClick},
                                      );

                                      PartnerEventAnalytics partnerEventAnalytics = new PartnerEventAnalytics(
                                        'BANNER',
                                        element.hash,
                                      );

                                      _clubBannerService.registerClickEvent(
                                        partnerEventAnalytics,
                                      );
                                      _launchPartnerURL(
                                        element.link,
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage('${Endpoints.baseUrl}${element.photo}'),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.warning,
                              color: AppColors.yellow,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              'Erro ao buscar as informações.\nEntre em contato com o suporte técnico!',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          'Sem ofertas no momento. Volte em breve!',
                        ),
                      );
                    }
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

  _launchPartnerURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

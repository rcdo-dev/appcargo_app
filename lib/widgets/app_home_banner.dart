import 'package:app_cargo/constants/endpoints.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/club_banner/club_partner.dart';
import 'package:app_cargo/domain/club_banner/home_banner.dart';
import 'package:app_cargo/domain/partner_event_analytics/partner_event_analytics.dart';
import 'package:app_cargo/routes.dart';
import 'package:app_cargo/services/club_banner/club_banner_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppHomeBanner extends StatelessWidget {
  ClubBannerService _clubBannerService = DIContainer().get<ClubBannerService>();
  final ClubPartner homeBanner;

  AppHomeBanner({@required this.homeBanner});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        PartnerEventAnalytics partnerEventAnalytics =
            new PartnerEventAnalytics('PARTNER', this.homeBanner.hash);
        _clubBannerService.registerClickEvent(partnerEventAnalytics);

        Navigator.pushNamed(context, Routes.clubPartnerDetails, arguments: {
          'partnerHash': this.homeBanner.hash,
          'partnerName': this.homeBanner.hash,
        });
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: 270,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(7)),
              color: Colors.white),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Image.network(
              Endpoints.baseUrl + this.homeBanner.photo,
              fit: BoxFit.fill,
            ),
          )),
    );
  }
}

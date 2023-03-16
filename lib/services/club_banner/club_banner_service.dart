import 'package:app_cargo/domain/club_banner/club_partner.dart';
import 'package:app_cargo/domain/club_banner/club_banner.dart';
import 'package:app_cargo/domain/club_banner/home_banner.dart';
import 'package:app_cargo/domain/club_banner/partner_banners.dart';
import 'package:app_cargo/domain/partner_event_analytics/partner_event_analytics.dart';

import '../../http/app_cargo_client.dart';

List<ClubPartner> _mapBannerPartners(Map<String, dynamic> json) {
  List<dynamic> bpsAsDyn = json["partners"] as List<dynamic>;
  return bpsAsDyn.map((bp) => ClubPartner.fromJson(bp)).toList(growable: false);
}

List<HomeBanner> _mapHomeBanner(List<dynamic> bannerList) {
  List<HomeBanner> _bannerList = new List<HomeBanner>();
  for (Map<String, dynamic> banner in bannerList) {
    _bannerList.add(HomeBanner.fromJson(banner));
  }
  return _bannerList;
}

PartnerBanners _mapBanners(Map<String, dynamic> json) {
  List<dynamic> bpsAsDyn = json["banners"] as List<dynamic>;

  List<ClubBanner> clubBanners = bpsAsDyn.map((bp) {
    return ClubBanner.fromJson(bp);
  }).toList(growable: false);

  ClubPartner clubPartner = ClubPartner.fromJson(json["partner"]);

  return PartnerBanners(partner: clubPartner, banners: clubBanners);
}

class ClubBannerService {
  AppCargoClient _appCargoClient;

  ClubBannerService(this._appCargoClient);

  Future<List<HomeBanner>> getBannersMenu({
    int pageSize = 15,
    int pageNumber = 0,
  }) {
    return this._appCargoClient.getList(
      "/v1/banners/forHomeScreen",
      _mapHomeBanner,
      queryParameters: {
        'pageSize': pageSize,
        'pageNumber': pageNumber,
      },
    ).catchError((e) {
      throw e;
    });
  }

  Future<List<ClubPartner>> getPartners({
    int pageSize = 15,
    int pageNumber = 0,
  }) {
    return this._appCargoClient.get(
      "/v1/partners",
      _mapBannerPartners,
      queryParameters: {
        'pageSize': pageSize,
        'pageNumber': pageNumber,
      },
    ).catchError((e) {
      throw e;
    });
  }

  Future<PartnerBanners> getBannersByPartner(
    String partnerHash, {
    int pageSize = 15,
    int pageNumber = 0,
  }) {
    return this._appCargoClient.get(
      "/v1/banners/byPartner/$partnerHash",
      _mapBanners,
      queryParameters: {
        'pageSize': pageSize,
        'pageNumber': pageNumber,
      },
    ).catchError((e) {
      throw e;
    });
  }

  Future<void> registerClickEvent(PartnerEventAnalytics partnerEventAnalytics) {
    return _appCargoClient
        .post("/v1/registerClick", null,
            data: PartnerEventAnalytics.toJson(partnerEventAnalytics))
        .then((response) {
      print('response: ${response}');
    });
  }
}

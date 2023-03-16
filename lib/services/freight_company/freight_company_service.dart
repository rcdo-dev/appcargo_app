import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/driver_personal_data/driver_personal_data.dart';
import 'package:app_cargo/domain/freight_company_detail/freight_company_detail.dart';
import 'package:app_cargo/domain/freight_company_feedback/freight_company_feedback.dart';
import 'package:app_cargo/domain/freight_summary/paged_freightco_summary.dart';
import 'package:app_cargo/http/app_cargo_client.dart';
import 'package:app_cargo/services/me/me_service.dart';

PagedFreightCoSummary _mapToPagedFreightCoSummary(Map<String, dynamic> json) =>
    PagedFreightCoSummary.fromJson(json);

FreightCompanyDetail _mapToFreightCompanyDetails(Map<String, dynamic> json) {
  return FreightCompanyDetail.fromJson(json);
}

List<FreightCompanyFeedback> _mapToListFreightCompanyFeedback(
    Map<String, dynamic> json) {
  List<FreightCompanyFeedback> _feedbacks = new List<FreightCompanyFeedback>();
  for (Map<String, dynamic> feedback in json["feedbacks"] as List) {
    _feedbacks.add(FreightCompanyFeedback.fromJson(feedback));
  }

  return _feedbacks;
}

class FreightCompanyService {
  AppCargoClient _dioClient;

  // Me service to get driver's data
  final MeService _meService = DIContainer().get<MeService>();

  FreightCompanyService(this._dioClient);

  Future<dynamic> search(
    int page,
    int pageSize, {
    String search = "",
  }) {
    return this._dioClient.get<dynamic>(
      "/v1/freightCompanies",
      _mapToPagedFreightCoSummary,
      queryParameters: {
        'query': search,
        'page': page,
        'pageSize': pageSize,
      },
    ).catchError((e) {
      throw e;
    });
  }

  Future<dynamic> getCompanyByRanking(int page, int pageSize) {
    return this._dioClient.get<dynamic>(
      "/v1/freightCompanies/ranking",
      _mapToPagedFreightCoSummary,
      queryParameters: {
        'page': page,
        'pageSize': pageSize,
      },
    ).catchError((e) {
      throw e;
    });
  }

  Future<FreightCompanyDetail> getCompanyDetails(String companyHash) {
    return this
        ._dioClient
        .get<FreightCompanyDetail>(
          "/v1/freightCompanies/$companyHash",
          _mapToFreightCompanyDetails,
        )
        .catchError((e) {
      throw e;
    });
  }

  Future<dynamic> getCompanyFeedbackPaged(
      String companyHash, int page, int pageSize) {
    return this._dioClient.get<dynamic>(
      "/v1/freightCompanies/$companyHash/feedback",
      _mapToListFreightCompanyFeedback,
      queryParameters: {
        'page': page,
        'pageSize': pageSize,
      },
    ).catchError((e) {
      throw e;
    });
  }

  Future<void> postCompanyFeedbackPaged(
      FreightCompanyFeedback feedback, String companyHash) {
    return this
        ._dioClient
        .post<dynamic>("/v1/freightCompanies/$companyHash/feedback", null,
            data: FreightCompanyFeedback.toJson(feedback))
        .catchError((e) {
      throw e;
    });
  }
}

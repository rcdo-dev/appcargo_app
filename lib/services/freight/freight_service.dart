import 'package:app_cargo/db/current_freight_dao.dart';
import 'package:app_cargo/db/decline_reasons_dao.dart';
import 'package:app_cargo/db/freight_proposals_dao.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/feight_proposal_decline_reasons/freight_proposal_decline_reasons.dart';
import 'package:app_cargo/domain/freight_details/freight_details.dart';
import 'package:app_cargo/domain/freight_search/freight_search_query.dart';
import 'package:app_cargo/domain/profile_summary/profile_summary.dart';
import 'package:app_cargo/http/api_error.dart';
import 'package:app_cargo/http/app_cargo_client.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:app_cargo/services/me/me_service.dart';

FreightDetails _mapToFreightDetails(Map<String, dynamic> json) {
  return FreightDetails.fromJson(json);
}

List<FreightDetails> _mapToListFreightDetails(Map<String, dynamic> json) {
  List<FreightDetails> queryResult = new List<FreightDetails>();
  for (Map<String, dynamic> result in json["freightDetails"]) {
    queryResult.add(FreightDetails.fromJson(result));
  }

  return queryResult;
}

class FreightService {
  AppCargoClient _dioClient;

  // DAOs for cache
  final FreightProposalDeclineReasonDAO _declineReasonsDAO =
      DIContainer().get<FreightProposalDeclineReasonDAO>();
  FreightProposalsDAO _freightProposalsDAO =
      new DIContainer().get<FreightProposalsDAO>();
  CurrentFreightDAO _currentFreightDAO =
      new DIContainer().get<CurrentFreightDAO>();

  // Other services
  MeService _meService = new DIContainer().get<MeService>();

  final ConfigurationService configurationService =
      DIContainer().get<ConfigurationService>();

  FreightService(this._dioClient);

  Future<void> acceptFreightProposal(FreightDetails freightDetails) {
    return _currentFreightDAO.queryAllRows().then((currentFreight) {
      if (currentFreight != null) {
        throw [
          new ApiError("CURRENT_FREIGHT_NOT_FINISHED",
              details: "Ainda existe um frete em progresso")
        ];
      }

      return this
          ._dioClient
          .post<dynamic>("/v1/freights/" + freightDetails.hash + "/accept", null)
          .then((value) {
        _freightProposalsDAO.delete(freightDetails.hash);
        _currentFreightDAO.insert(freightDetails);
      }).catchError((e) {
        throw e;
      });
    });
  }

  Future<void> canRefuseFreightProposal() {
    return _currentFreightDAO.queryAllRows().then((currentFreight) {
      if (currentFreight != null) {
        throw [
          new ApiError("CURRENT_FREIGHT_NOT_FINISHED",
              details: "Ainda existe um frete em progesso")
        ];
      }

      return;
    });
  }

  Future<void> refuseFreightProposal(FreightDetails freightDetails,
      FreightProposalDeclineReason declineReason) {
    print(FreightProposalDeclineReason.toJson(declineReason));
    return this
        ._dioClient
        .post<dynamic>("/v1/freights/" + freightDetails.hash + "/decline", null,
            data: FreightProposalDeclineReason.toJson(declineReason))
        .then((value) {
      _freightProposalsDAO.delete(freightDetails.hash);
    }).catchError((e) {
      throw e;
    });
  }

  Future<FreightDetails> getCurrentFreight() {
    return _currentFreightDAO.queryAllRows().then((value) {
      if (value != null) {
        return value;
      } else {
        return _meService.getAllDriverData().then((value) {
          if (value != null) {
            return value.current;
          } else {
            return null;
          }
        });
      }
    });
  }

  Future<List<FreightDetails>> getAllFreightProposals() {
    return _freightProposalsDAO.queryAllRows().then((value) {
      if (value != null) {
        return value;
      } else {
        return _meService
            .getAllDriverData()
            .then((ProfileSummary profileSummary) {
          if (profileSummary != null) {
            return profileSummary.proposals;
          } else {
            return new List<FreightDetails>();
          }
        });
      }
    });
  }

  Future<List<FreightProposalDeclineReason>> getAllDeclineReasons() {
    return _declineReasonsDAO
        .queryAllRows()
        .then((List<FreightProposalDeclineReason> queryResult1) {
      // Verify if exist dome data on Decline Reasons table
      if (queryResult1.length > 0) {
        return queryResult1;
        // If there isn't any data do the request and save it in the DB
      } else {
        return _meService.getDeclineReasons().then(
          (List<FreightProposalDeclineReason> _reasons) {
            _declineReasonsDAO.deleteAll();
            return _declineReasonsDAO
                .insertAll(_reasons)
                .then((List<int> queryResult2) {
              return _reasons;
            });
          },
        );
      }
    });
  }

  Future<FreightDetails> getFreightDetails(String freightHash) {
    return this
        ._dioClient
        .get<FreightDetails>("/v1/freights/$freightHash", _mapToFreightDetails)
        .catchError((e) {
      throw e;
    });
  }

  Future<List<FreightDetails>> searchFreights(
      FreightSearchQuery freightSearch) {
    print(FreightSearchQuery.toJson(freightSearch));
    return this
        ._dioClient
        .post<List<FreightDetails>>("/v1/freights", _mapToListFreightDetails,
            data: FreightSearchQuery.toJson(freightSearch))
        .catchError((e) {
      throw e;
    });
  }
}

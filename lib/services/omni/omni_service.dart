import 'package:app_cargo/domain/omni/civil_states/omni_civil_states.dart';
import 'package:app_cargo/domain/omni/financing_options/omni_financing_options.dart';
import 'package:app_cargo/domain/omni/professional_classes/omni_professional_class.dart';
import 'package:app_cargo/domain/omni/professions/omni_profession.dart';
import 'package:app_cargo/domain/omni/proposals_history/history_users_proposals.dart';
import 'package:app_cargo/domain/omni/submit_financing_proposal/omni_submit_financing_proposal.dart';
import 'package:app_cargo/domain/omni/users_proposals/simulation_data.dart';
import 'package:app_cargo/http/api_error.dart';
import 'package:app_cargo/http/fipe_client.dart';
import 'package:app_cargo/services/omni/omni_endpoints.dart';
import 'package:app_cargo/domain/omni/new_proposal_requrest/simulation.dart';
import 'package:app_cargo/http/app_cargo_client.dart';
import 'package:app_cargo/services/omni/omni_map_helper.dart';

class OmniService {
  AppCargoClient _appCargoClient;

  OmniService(this._appCargoClient);

  Future<List<SimulationData>> mySimulations() async {
    return this
        ._appCargoClient
        .getList(OmniEndpoints.urlMySimulations,
            OmniMapHelper.mapToListSimulationData)
        .catchError((err) {
      throw err;
    });
  }

  Future<HistoryUsersProposals> proposalsHistoryRequest(
      String proposalsFriendlyHash) {
    return this
        ._appCargoClient
        .get(OmniEndpoints.urlMySimulations + "/$proposalsFriendlyHash",
            OmniMapHelper.mapToListHistoryProposalsData)
        .catchError((err) {
      throw err;
    });
  }

  Future<List<OmniFinancingOptions>> getFinancingOptions(
      String proposalFriendlyHash) async {
    return this
        ._appCargoClient
        .getList(
            "${OmniEndpoints.urlMySimulations}/$proposalFriendlyHash/options",
            OmniMapHelper.mapToListFinancingOptions)
        .catchError((err) {
      throw err;
    });
  }

  Future<dynamic> sendSimulation(Simulation simulation) {
    return this
        ._appCargoClient
        .postWithoutHandleError(
          OmniEndpoints.urlSendPreSimulation,
          null,
          data: Simulation.toJson(simulation),
        )
        .catchError((error) {
      throw error;
    });
  }

  Future<dynamic> sendFinancingProposal(
      OmniSubmitFinancingProposal proposal, String proposalFriendlyHash) {
    return this
        ._appCargoClient
        .putStringResponse<String>(
          "${OmniEndpoints.urlSendFinancingProposal}/$proposalFriendlyHash/submitProposal",
          mapper: OmniMapHelper.mapFinancingResponse,
          data: OmniSubmitFinancingProposal.toJson(proposal),
        )
        .catchError((error) {
      throw error;
    });
  }

  Future<List<OmniProfession>> getProfessions() {
    return this
        ._appCargoClient
        .getList(OmniEndpoints.urlProfessionsList,
            OmniMapHelper.mapToListProfessionsData)
        .catchError((err) {
      throw err;
    });
  }

  Future<List<OmniProfessionalClass>> getProfessionalClasses() {
    return this
        ._appCargoClient
        .getList(OmniEndpoints.urlProfessionalClassesList,
            OmniMapHelper.mapToListProfessionalClassesData)
        .catchError((err) {
      throw err;
    });
  }

  Future<List<OmniCivilStates>> getCivilStates() {
    return this
        ._appCargoClient
        .getList(
            OmniEndpoints.urlCivilStates, OmniMapHelper.mapToListCivilStates)
        .catchError((err) {
      throw err;
    });
  }
}

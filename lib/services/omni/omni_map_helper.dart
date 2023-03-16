import 'package:app_cargo/domain/omni/civil_states/omni_civil_states.dart';
import 'package:app_cargo/domain/omni/financing_options/omni_financing_options.dart';
import 'package:app_cargo/domain/omni/professional_classes/omni_professional_class.dart';
import 'package:app_cargo/domain/omni/professions/omni_profession.dart';
import 'package:app_cargo/domain/omni/proposals_history/history_users_proposals.dart';
import 'package:app_cargo/domain/omni/users_proposals/simulation_data.dart';
import 'package:app_cargo/http/api_error.dart';

class OmniMapHelper {
  static List<SimulationData> mapToSimulationData(Map<String, dynamic> json) {
    List<dynamic> simulations = json["my_simulations"] as List<dynamic>;
    return simulations
        .map((simulation) => SimulationData.fromJson(simulation))
        .toList(growable: false);
  }

  static List<SimulationData> mapToListSimulationData(
      List<dynamic> simulations) {
    List<SimulationData> _simulationsList = new List<SimulationData>();
    for (Map<String, dynamic> simulation in simulations) {
      _simulationsList.add(SimulationData.fromJson(simulation));
    }
    return _simulationsList;
  }

  static List<OmniFinancingOptions> mapToListFinancingOptions(
      List<dynamic> financingOptions) {
    List<OmniFinancingOptions> _financingOptions =
        new List<OmniFinancingOptions>();
    for (Map<String, dynamic> option in financingOptions) {
      _financingOptions.add(OmniFinancingOptions.fromJson(option));
    }
    return _financingOptions;
  }

  static HistoryUsersProposals mapToListHistoryProposalsData(
      Map<String, dynamic> json) {
    return HistoryUsersProposals.fromJson(json);
  }

  static List<OmniProfession> mapToListProfessionsData(
      List<dynamic> professions) {
    List<OmniProfession> _professionsList = new List<OmniProfession>();
    for (Map<String, dynamic> profession in professions) {
      _professionsList.add(OmniProfession.fromJson(profession));
    }
    return _professionsList;
  }

  static List<OmniProfessionalClass> mapToListProfessionalClassesData(
      List<dynamic> professionalClasses) {
    List<OmniProfessionalClass> _professionalClasses =
        new List<OmniProfessionalClass>();
    for (Map<String, dynamic> professionalClass in professionalClasses) {
      _professionalClasses
          .add(OmniProfessionalClass.fromJson(professionalClass));
    }
    return _professionalClasses;
  }

  static List<OmniCivilStates> mapToListCivilStates(List<dynamic> civilStates) {
    List<OmniCivilStates> _civilStates = new List<OmniCivilStates>();
    for (Map<String, dynamic> civilState in civilStates) {
      _civilStates.add(OmniCivilStates.fromJson(civilState));
    }
    return _civilStates;
  }

  static String mapFinancingResponse(String response) {
  }
}

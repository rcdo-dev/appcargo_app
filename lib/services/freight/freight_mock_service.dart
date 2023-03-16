import 'package:app_cargo/db/current_freight_dao.dart';
import 'package:app_cargo/db/decline_reasons_dao.dart';
import 'package:app_cargo/db/freight_proposals_dao.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/address/address.dart';
import 'package:app_cargo/domain/address_summary/address_summary.dart';
import 'package:app_cargo/domain/city/city.dart';
import 'package:app_cargo/domain/feight_proposal_decline_reasons/freight_proposal_decline_reasons.dart';
import 'package:app_cargo/domain/freight_company_summary/freight_company_summary.dart';
import 'package:app_cargo/domain/freight_details/freight_details.dart';
import 'package:app_cargo/domain/freight_search/freight_search_query.dart';
import 'package:app_cargo/domain/freight_summary/freight_summary.dart';
import 'package:app_cargo/domain/lat_lng/lat_lng.dart';
import 'package:app_cargo/domain/state/state.dart';

import 'package:app_cargo/services/config/config_service.dart';

import 'freight_service.dart';

String hash = "72543da6-b7ad-11e9-a2a3-2a2ae2dbcce4";
Address defaultAddress = new Address(
  state: new AddressState(hash: hash, acronym: "SP"),
  city: new City(hash: hash, name: "Mogi das Cruzes"),
  neighborhood: "Mogilar",
  street: "Rua Barao de Jaceguai",
  cep: "08866-123",
  number: "112",
  formatted: "Rua Barao de Jaceguai, 112, Mogi das Cruzes - SP",
  position: new LatLng(longitude: "-1", latitude: "1"),
);
AddressSummary defaultAddressSummary = new AddressSummary(
  stateHash: hash,
  cityHash: hash,
  cityName: "Mogi das Cruzes",
  stateAcronym: "SP",
  position: new LatLng(latitude: "-1", longitude: "1"),
  formatted: "Rua Pedro Alvares, 12, Mogi das Cruzes - SP",
);
FreightSummary defaultFreightSummary = new FreightSummary(
  hash: hash,
  to: defaultAddressSummary,
  from: defaultAddressSummary,
  freightCoContact: "11987655678",
  distanceInMeters: "2000",
  code: "COD-123128301",
);
FreightCompanySummary defaultFreightCompanySummary = new FreightCompanySummary(
  hash: hash,
  name: "Padrao Transportes",
  photo: "https://img.olx.com.br/images/74/746919020076424.jpg",
  address: defaultAddressSummary,
  contact: "11975846273",
  positionInRanking: 2,
  rating: 4,
);

FreightDetails defaultFreightDetails = new FreightDetails(
  code: "COD-67426426",
  distanceInMeters: "5000",
  freightCoContact: "11947382983",
  from: defaultAddressSummary,
  to: defaultAddressSummary,
  hash: hash,
  freightCompany: defaultFreightCompanySummary,
  observation: "Carga delicada",
  paymentMethod: FreightPaymentMethodType.ADVANCE_PLUS_BALANCE,
  product: "Caixas de madeira",
  species: "Organica",
  termInDays: "25",
  tollInCents: "4000",
  valueInCents: "400000",
  weightInGrams: "500000",
);

class FreightMockService implements FreightService {
  FreightProposalsDAO _freightProposalsDAO =
      new DIContainer().get<FreightProposalsDAO>();
  CurrentFreightDAO _currentFreightDAO =
      new DIContainer().get<CurrentFreightDAO>();
  final FreightProposalDeclineReasonDAO _declineReasonsDAO =
      DIContainer().get<FreightProposalDeclineReasonDAO>();

  @override
  Future<bool> acceptFreightProposal(FreightDetails freightDetails) {
    return Future.delayed(Duration(seconds: 1));
  }

  @override
  ConfigurationService get configurationService => null;

  @override
  Future<List<FreightProposalDeclineReason>> getDeclineReasons() {
    return Future.delayed(
        Duration(seconds: 1),
        () => [
              new FreightProposalDeclineReason(
                  hash: "72543da6",
                  description: "Motivo 1"),
              new FreightProposalDeclineReason(
                  hash: "72543da6",
                  description: "Motivo 2"),
              new FreightProposalDeclineReason(
                  hash: "72543da6",
                  description: "Motivo 3"),
            ]);
  }

  @override
  Future<void> refuseFreightProposal(FreightDetails freightDetails,
      FreightProposalDeclineReason declineReason) {
    return Future.delayed(Duration(seconds: 1)).then((value) {
      _freightProposalsDAO.delete(freightDetails.hash);
    });
  }

  @override
  Future<FreightDetails> getCurrentFreight() {
    return _currentFreightDAO.queryAllRows();
  }

  @override
  Future<List<FreightDetails>> getAllFreightProposals() {
    return _freightProposalsDAO.queryAllRows();
  }

  @override
  Future<List<FreightProposalDeclineReason>> getAllDeclineReasons() {
    return _declineReasonsDAO.queryAllRows();
  }

  @override
  Future<FreightDetails> getFreightDetails(String freightHash) {
    return Future.value(defaultFreightDetails);
  }

  @override
  Future<void> canRefuseFreightProposal() {
    // TODO: implement canRefuseFreightProposal
    return null;
  }

  @override
  Future<List<FreightDetails>> searchFreights(FreightSearchQuery freightSearchQuery) {
    // TODO: implement searchFreights
    return null;
  }
}

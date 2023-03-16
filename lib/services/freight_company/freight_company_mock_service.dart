import 'package:app_cargo/domain/address/address.dart';
import 'package:app_cargo/domain/address_summary/address_summary.dart';
import 'package:app_cargo/domain/city/city.dart';
import 'package:app_cargo/domain/freight_company_detail/freight_company_detail.dart';
import 'package:app_cargo/domain/freight_company_feedback/freight_company_feedback.dart';
import 'package:app_cargo/domain/freight_company_summary/freight_company_summary.dart';
import 'package:app_cargo/domain/freight_summary/paged_freightco_summary.dart';
import 'package:app_cargo/domain/lat_lng/lat_lng.dart';
import 'package:app_cargo/domain/state/state.dart';

import 'freight_company_service.dart';

String hash = "72543da6-b7ad-11e9-a2a3-2a2ae2dbcce4";
AddressSummary defaultAddressSummary = new AddressSummary(
    stateHash: hash,
    cityHash: hash,
    cityName: "Mogi das Cruzes",
    stateAcronym: "SP",
    position: new LatLng(latitude: "-1", longitude: "1"),
    formatted: "Rua Pedro Alvares, 12, Mogi das Cruzes - SP");
FreightCompanySummary defaultFreightCompanySummary = new FreightCompanySummary(
  hash: hash,
  name: "Compania Padrao",
  photo: "https://img.olx.com.br/images/74/746919020076424.jpg",
  rating: 4,
  positionInRanking: 1,
  contact: "11988881111",
  address: defaultAddressSummary,
);
Address defaultAddress = new Address(
    state: new AddressState(
        name: "Rio de Janeiro", hash: hash, acronym: "RJ", cities: []),
    city: new City(hash: hash, name: "Rio de Janeiro"),
    position: new LatLng(latitude: "-1", longitude: "1"),
    neighborhood: "Copacabana",
    cep: "08888-123",
    number: "11",
    street: "Rua Copacabana",
    formatted: "Rua Copacabana, 11, Rio de Janeriro - Rio de Janeiro");
List<FreightCompanyFeedback> defaultCompanyFeedbacks = [
  new FreightCompanyFeedback(
      rating: 3, description: "Compania mediana", driver: "Caminhoneiro 1"),
  new FreightCompanyFeedback(
      rating: 1, description: "Compania ruim", driver: "Caminhoneiro 2"),
  new FreightCompanyFeedback(
      rating: 4, description: "Compania boa", driver: "Caminhoneiro 3"),
];
FreightCompanyDetail defaultFreightCompanyDetail = new FreightCompanyDetail(
    rankingPosition: 1,
    rating: 4,
    contact: "11988881111",
    hash: hash,
    name: "Transportadora Padrao",
    photo: "https://img.olx.com.br/images/74/746919020076424.jpg",
    address: defaultAddress,
    highlightedFeedback: defaultCompanyFeedbacks);

class FreightCompanyMockService implements FreightCompanyService {

  @override
  Future<FreightCompanyDetail> getCompanyDetails(String companyHash) {
    return Future.delayed(
        Duration(seconds: 1), () => defaultFreightCompanyDetail);
  }

  @override
  Future<List<FreightCompanyFeedback>> getCompanyFeedbackPaged(
      String companyHash, int page, int pageSize) {
    return Future.delayed(Duration(seconds: 1), () => defaultCompanyFeedbacks);
  }


  @override
  Future<bool> postCompanyFeedbackPaged(
      FreightCompanyFeedback feedback, String companyHash) {
    return Future.delayed(Duration(seconds: 1), () => true);
  }

  @override
  Future<PagedFreightCoSummary> search(int page, int pageSize, {String search = ""}) {
    return null;
  }

  @override
  Future<PagedFreightCoSummary> getCompanyByRanking(int page, int pageSize) {
    return null;
  }
}

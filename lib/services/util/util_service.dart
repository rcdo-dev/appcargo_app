import 'package:app_cargo/constants/endpoints.dart';
import 'package:app_cargo/domain/address/address_api.dart';
import 'package:app_cargo/domain/bank/banks.dart';
import 'package:app_cargo/domain/city/city.dart';
import 'package:app_cargo/http/app_cargo_client.dart';
import 'package:app_cargo/http/fipe_client.dart';

List<City> _mapToListCities(List<dynamic> cities) {
  List<City> _cities = new List<City>();
  for (Map<String, dynamic> city in cities) {
    _cities.add(City.fromJson(city));
  }
  return _cities;
}

class UtilService {
  FIPEClient _client;
  AppCargoClient _appCargoClient;

  UtilService(this._client, this._appCargoClient);

  Future<List<City>> getCities(String stateAcronym) {
    return this
        ._client
        .getList<List<City>>(
          Endpoints.mobileBaseUrl + "/v1/states/$stateAcronym/cities",
          _mapToListCities,
        )
        .catchError((e) {
      throw e;
    });
  }

  Future<AddressApi> getAddressFromCep(String cep) {
    return this
        ._client
        .getObject("https://viacep.com.br/ws/$cep/json/", AddressApi.fromJson)
        .catchError((e) {
      throw e;
    });
  }

  Future<Banks> getBanks() {
    return this
        ._appCargoClient
        .get<Banks>(
          "/v1/banks",
          Banks.fromJson,
        )
        .catchError((e) {
      throw e;
    });
  }
}

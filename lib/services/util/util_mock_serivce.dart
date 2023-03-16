import 'package:app_cargo/domain/address/address_api.dart';
import 'package:app_cargo/domain/bank/banks.dart';
import 'package:app_cargo/domain/city/city.dart';
import 'package:app_cargo/services/util/util_service.dart';

City defaultCity1 = new City(name: "Mogi das Cruzes", hash: "hash1");
City defaultCity2 = new City(name: "Sorocaba", hash: "hash2");
City defaultCity3 = new City(name: "Paranapiacaba", hash: "hash3");
City defaultCity4 = new City(name: "Natal", hash: "hash4");
City defaultCity5 = new City(name: "Rio de Janeiro", hash: "hash5");

class UtilMockService implements UtilService {
  @override
  Future<List<City>> getCities(String stateAcronym) {
    return Future.value(
        [defaultCity1, defaultCity2, defaultCity3, defaultCity4, defaultCity5]);
  }

  @override
  Future<AddressApi> getAddressFromCep(String cep) {
    // TODO: implement getAddressFromCep
    return null;
  }

  @override
  Future<Banks> getBanks() {
    // TODO: implement getBanks
    return null;
  }
}

import 'package:app_cargo/domain/city/city.dart';
import 'package:app_cargo/domain/request_freight_questionnaire/request_freight_questionnaire.dart';
import 'package:app_cargo/domain/truck/truck.dart';

class RequestFreightQuestionnaireController {
  TruckType truckType;
  TrailerType trailerType;
  int weightCapacity;
  City city;
  City destinationCity;
  String uf;
  String lastUF;

  RequestFreightQuestionnaireController() {
    this.truckType = TruckType.UTILITARIO;
    this.trailerType = TrailerType.FECHADO;
    // this.city = new City(name: "São Paulo", hash: "2s16mCQl2p9QQdugqLii5J");
    this.uf = "SP";
    this.lastUF = uf;
  }

  RequestFreightQuestionnaire getQuestionnaireData() {
    TrailerType trailerType;
    if (this.truckType == TruckType.UTILITARIO) {
      trailerType = this.trailerType;
    } else {
      trailerType = null;
    }

    return RequestFreightQuestionnaire(
      truckType: this.truckType.uniqueName(),
      cityFriendlyHash: this.city.hash,
      trailerType: trailerType == null ? null : trailerType.uniqueName(),
      weightCapacity:
          this.truckType == TruckType.UTILITARIO ? this.weightCapacity : 0,
    );
  }

  RequestFreightQuestionnaire getQuestionnaireDataPremium() {
    TrailerType trailerType;
    if (this.truckType == TruckType.UTILITARIO) {
      trailerType = this.trailerType;
    } else {
      trailerType = null;
    }

    return RequestFreightQuestionnaire(
      truckType: this.truckType.uniqueName(),
      cityFriendlyHash: this.city.hash,
      destinationCityHash: this.destinationCity.hash,
      trailerType: trailerType == null ? null : trailerType.uniqueName(),
      weightCapacity:
          this.truckType == TruckType.UTILITARIO ? this.weightCapacity : 0,
    );
  }
}

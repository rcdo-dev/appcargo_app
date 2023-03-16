import 'package:app_cargo/domain/address/address.dart';
import 'package:app_cargo/domain/address_summary/address_summary.dart';
import 'package:app_cargo/domain/city/city.dart';
import 'package:app_cargo/domain/freight_company_summary/freight_company_summary.dart';
import 'package:app_cargo/domain/freight_details/freight_details.dart';
import "package:app_cargo/domain/freight_summary/freight_summary.dart";
import 'package:app_cargo/domain/lat_lng/lat_lng.dart';
import 'package:app_cargo/domain/state/state.dart';
import "package:sqflite/sqflite.dart";

import "database_provider.dart";

final String table = "current_freight";
final String hashColumn = "hash";

class CurrentFreightDAO {
  final DatabaseProvider _databaseProvider;

  CurrentFreightDAO(this._databaseProvider);

  // Verify if the hash already exist in the db and them return
  Future<int> insert(FreightDetails row) async {
    Database db = await _databaseProvider.database;
    FreightDetails freightDetails = await querySingleRow(row.hash);
    if (freightDetails == null) {
      return await db.insert(
        table,
        toMap(row),
      );
    } else {
      return await update(row);
    }
  }

  Future<FreightDetails> queryAllRows() async {
    Database db = await _databaseProvider.database;
    List<Map<String, dynamic>> result = await db.query(table);
    
    if (result.length > 0) {
      return fromMap(result[0]);
    } else {
      return null;
    }
  }

  // Query for a hash and return the first value of the query
  Future<FreightDetails> querySingleRow(String hash) async {
    Database db = await _databaseProvider.database;
    List<Map<String, dynamic>> result = await await db
        .query(table, where: '$hashColumn = ?', whereArgs: [hash]);
    if (result.length == 0) return null;
    return fromMap(result[0]);
  }

  // Todos os métodos : inserir, consultar, atualizar e excluir,
  // também podem ser feitos usando  comandos SQL brutos.
  // Esse método usa uma consulta bruta para fornecer a contagem de linhas.
  Future<int> queryRowCount() async {
    Database db = await _databaseProvider.database;
    return Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $table"));
  }

  // Update a freight summary row by their hash
  Future<int> update(FreightDetails row) async {
    Database db = await _databaseProvider.database;
    String hash = row.hash;
    return await db
        .update(table, toMap(row), where: "$hashColumn = ?", whereArgs: [hash]);
  }

  // Exclui a linha especificada pelo id. O número de linhas afetadas é
  // retornada. Isso deve ser igual a 1, contanto que a linha exista.
  Future<int> delete() async {
    Database db = await _databaseProvider.database;
    return await db.delete(table, where: "id = 1");
  }

  Map<String, dynamic> toMap(FreightDetails freightDetails) {
    return <String, dynamic>{
      "hash": freightDetails.hash,
      "code": freightDetails.code,
      "fromCityHash": freightDetails.from.cityHash,
      "fromStateHash": freightDetails.from.stateHash,
      "fromCityName": freightDetails.from.cityName,
      "fromStateAcronym": freightDetails.from.stateAcronym,
      "fromLat": freightDetails.from.position.latitude,
      "fromLng": freightDetails.from.position.longitude,
      "fromFormatted": freightDetails.from.formatted,
      "toCityHash": freightDetails.to.cityHash,
      "toStateHash": freightDetails.to.stateHash,
      "toCityName": freightDetails.to.cityName,
      "toStateAcronym": freightDetails.to.stateAcronym,
      "toLat": freightDetails.to.position.latitude,
      "toLng": freightDetails.to.position.longitude,
      "toFormatted": freightDetails.to.formatted,
      "distanceInMeters": freightDetails.distanceInMeters,
      "freightCoContact": freightDetails.freightCoContact,
      "weightInGrams": freightDetails.weightInGrams,
      "valueInCents": freightDetails.valueInCents,
      "tollInCents": freightDetails.tollInCents,
      "termInDays": freightDetails.termInDays,
      "paymentMethod": FreightPaymentMethodType.toJson(freightDetails.paymentMethod),
      "status": FreightStatus.toJson(freightDetails.status),
      "product": freightDetails.product,
      "species": freightDetails.species,
      "observations": freightDetails.observation,
      "freightCompanyHash": freightDetails.freightCompany.hash,
      "freightCompanyAccessCredentialHash":freightDetails.freightCompany.accessCredentialHash,
      "freightCompanyName": freightDetails.freightCompany.name,
      "freightCompanyPhoto": freightDetails.freightCompany.photo,
      "freightCompanyRating": freightDetails.freightCompany.rating,
      "freightCompanyPositionInRanking":
          freightDetails.freightCompany.positionInRanking,
      "freightCompanyContact": freightDetails.freightCompany.contact,
      "freightCompanyCityHash": freightDetails.freightCompany.address.cityHash,
      "freightCompanyStateHash":
          freightDetails.freightCompany.address.stateHash,
      "freightCompanyCityName": freightDetails.freightCompany.address.cityName,
      "freightCompanyStateAcronym":
          freightDetails.freightCompany.address.stateAcronym,
      "freightCompanyLat": freightDetails.freightCompany.address.position.latitude,
      "freightCompanyLng": freightDetails.freightCompany.address.position.longitude,
      "freightCompanyFormatted": freightDetails.freightCompany.address.formatted
    };
  }

  FreightDetails fromMap(Map<String, dynamic> map) {
    return new FreightDetails(
      hash: map["hash"],
      code: map["code"],
      distanceInMeters: map["distanceInMeters"],
      freightCoContact: map["freightCoContact"],
      observation: map["observations"],
      paymentMethod: FreightPaymentMethodType.fromJson(map["paymentMethod"]),
      status: FreightStatus.fromJson(map["status"]),
      product: map["produtct"],
      species: map["species"],
      termInDays: map["termInDays"],
      tollInCents: map["tollInCents"],
      valueInCents: map["valueInCents"],
      weightInGrams: map["weightInGrams"],
      from: new AddressSummary(
        cityHash: map["fromCityHash"],
        cityName: map["fromCityName"],
        stateAcronym: map["fromStateAcronym"],
        stateHash: map["fromStateHash"],
        position: new LatLng(
          longitude: map["fromLng"],
          latitude: map["fromLat"],
        ),
        formatted: map["fromFormatted"],
      ),
      to: new AddressSummary(
        cityHash: map["toCityHash"],
        cityName: map["toCityName"],
        stateAcronym: map["toStateAcronym"],
        stateHash: map["toStateHash"],
        position: new LatLng(
          longitude: map["toLng"],
          latitude: map["toLat"],
        ),
        formatted: map["toFormatted"],
      ),
      freightCompany: new FreightCompanySummary(
        hash: map["freightCompanyHash"],
        accessCredentialHash: map["freightCompanyAccessCredentialHash"],
        name: map["freightCompanyName"],
        contact: map["freightCompanyContact"],
        photo: map["freightCompanyPhoto"],
        rating: int.parse(map["freightCompanyRating"]),
        positionInRanking: int.parse(map["freightCompanyPositionInRanking"] ?? "0"),
        address: new AddressSummary(
          formatted: map["freightCompanyFormatted"],
          position: new LatLng(
            longitude: map["freightCompanyLng"],
            latitude: map["freightCompanyLat"],
          ),
          stateAcronym: map["freightCompanyStateAcronym"],
          cityName: map["freightCompanyCityName"],
          cityHash: map["freightCompanyCityHash"],
          stateHash: map["freightCompanyStateHash"],
        ),
      ),
    );
  }
}

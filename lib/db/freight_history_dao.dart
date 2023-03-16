import 'package:app_cargo/domain/address_summary/address_summary.dart';
import "package:app_cargo/domain/freight_summary/freight_summary.dart";
import 'package:app_cargo/domain/lat_lng/lat_lng.dart';
import "package:sqflite/sqflite.dart";

import "database_provider.dart";

final String table = "history_freight";
final String hashColumn = "hash";

class FreightHistoryDAO {
  final DatabaseProvider _databaseProvider;

  FreightHistoryDAO(this._databaseProvider);

  // Verify if the hash already exist in the db and them return
  Future<int> insert(FreightSummary row) async {
    Database db = await _databaseProvider.database;
    FreightSummary freightSummary = await querySingleRow(row.hash);
    if (freightSummary == null) {
      return await db.insert(
        table,
        toMap(row),
      );
    } else {
      return await update(row);
    }
  }

  // Todas as linhas são retornadas como uma lista de mapas, onde cada mapa é
  // uma lista de valores-chave de colunas.
  Future<List<FreightSummary>> queryAllRows() async {
    Database db = await _databaseProvider.database;
    List<FreightSummary> list = new List<FreightSummary>();
    List<Map<String, dynamic>> result = await db.query(table);
    for (Map<String, dynamic> item in result) {
      list.add(fromMap(item));
    }
    return list;
  }

  // Query for a hash and return the first value of the query
  Future<FreightSummary> querySingleRow(String hash) async {
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
  Future<int> update(FreightSummary row) async {
    Database db = await _databaseProvider.database;
    String hash = row.hash;
    return await db
        .update(table, toMap(row), where: "$hashColumn = ?", whereArgs: [hash]);
  }

  // Exclui a linha especificada pelo id. O número de linhas afetadas é
  // retornada. Isso deve ser igual a 1, contanto que a linha exista.
  Future<int> delete(String hash) async {
    Database db = await _databaseProvider.database;
    return await db.delete(table, where: "$hashColumn = ?", whereArgs: [hash]);
  }

  Map<String, dynamic> toMap(FreightSummary freightSummary) {
    return <String, dynamic>{
      "hash": freightSummary.hash,
      "code": freightSummary.code,
      "fromCityHash": freightSummary.from.cityHash,
      "fromStateHash": freightSummary.from.stateHash,
      "fromCityName": freightSummary.from.cityName,
      "fromStateAcronym": freightSummary.from.stateAcronym,
      "fromLat": freightSummary.from.position.latitude,
      "fromLng": freightSummary.from.position.longitude,
      "toCityHash": freightSummary.to.cityHash,
      "toStateHash": freightSummary.to.stateHash,
      "toCityName": freightSummary.to.cityName,
      "toStateAcronym": freightSummary.to.stateAcronym,
      "toLat": freightSummary.to.position.latitude,
      "toLng": freightSummary.to.position.longitude,
      "distanceInMeters": freightSummary.distanceInMeters,
      "freightCoContact": freightSummary.freightCoContact,
    };
  }

  FreightSummary fromMap(Map<String, dynamic> map) {
    return new FreightSummary(
        hash: map["hash"],
        code: map["code"],
        distanceInMeters: map["distanceInMeters"],
        freightCoContact: map["freightCoContact"],
        from: new AddressSummary(
            stateAcronym: map["fromStateAcronym"],
            cityName: map["fromCityName"],
            cityHash: map["fromCityHash"],
            stateHash: map["fromStateHash"],
            position: new LatLng(longitude: map["fromLng"], latitude: map["fromLat"])),
        to: new AddressSummary(
            stateHash: map["toStateHash"],
            cityHash: map["toCityHash"],
            cityName: map["toCityName"],
            stateAcronym: map["toStateAcronym"],
            position: new LatLng(latitude: map["toLat"], longitude: map["toLng"])));
  }
}

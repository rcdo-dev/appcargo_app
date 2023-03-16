import 'package:app_cargo/domain/city/city.dart';
import 'package:app_cargo/domain/driver_contact_data/driver_contact_data.dart';
import 'package:app_cargo/domain/state/state.dart';
import "package:sqflite/sqflite.dart";

import "database_provider.dart";

final String table = "driver_contact_data";

class DriverContactDataDAO {
  final DatabaseProvider _databaseProvider;

  DriverContactDataDAO(this._databaseProvider);

  // Verify if the hash already exist in the db and them return
  Future<int> insert(DriverContactData row) async {
    Database db = await _databaseProvider.database;
    DriverContactData driverContactData = await queryAllRows();
    if (driverContactData == null) {
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
  Future<DriverContactData> queryAllRows() async {
    Database db = await _databaseProvider.database;
    List<DriverContactData> list = new List<DriverContactData>();
    List<Map<String, dynamic>> result = await db.query(table);
    for (Map<String, dynamic> item in result) {
      list.add(fromMap(item));
    }
    return list.length > 0 ? list[0] : null;
  }

  // Count the db rows
  Future<int> queryRowCount() async {
    Database db = await _databaseProvider.database;
    return Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $table"));
  }

  // Update a row
  Future<int> update(DriverContactData row) async {
    Database db = await _databaseProvider.database;
    String hash = row.cellNumber;
    return await db.update(table, toMap(row), where: "id = 1");
  }

  // Delete a row
  Future<int> delete() async {
    Database db = await _databaseProvider.database;
    return await db.delete(table, where: "id = 1");
  }

  Map<String, dynamic> toMap(DriverContactData driverContactData) {
    return <String, dynamic>{
      "cep": driverContactData.cep ?? "",
      "street": driverContactData.street ?? "",
      "number": driverContactData.number ?? "",
      "neighborhood": driverContactData.neighborhood ?? "",
      "stateHash": driverContactData.state != null ? driverContactData.state.hashCode : "",
      "stateAcronym": driverContactData.state != null ? driverContactData.state.acronym : "",
      "cityHash": driverContactData.city != null ? driverContactData.city.hashCode : "",
      "cityName": driverContactData.city != null ? driverContactData.city.name : "",
      "formatted": driverContactData.formatted ?? "",
      "cellNumber": driverContactData.cellNumber ?? "",
    };
  }

  DriverContactData fromMap(Map<String, dynamic> map) {
    return new DriverContactData(
      cep: map["cep"],
      street: map["street"],
      number: map["number"],
      neighborhood: map["neighborhood"],
      state: new AddressState(
        hash: map["stateHash"],
        acronym: map["stateAcronym"],
      ),
      city: new City(
        hash: map["cityHash"],
        name: map["cityName"],
      ),
      formatted: map["formatted"],
      cellNumber: map["cellNumber"],
    );
  }
}

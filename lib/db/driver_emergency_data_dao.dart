import 'package:app_cargo/domain/driver_emergency_data/driver_emergency_data.dart';
import "package:sqflite/sqflite.dart";

import "database_provider.dart";

final String table = "driver_emergency_data";

class DriverEmergencyDataDAO {
  final DatabaseProvider _databaseProvider;

  DriverEmergencyDataDAO(this._databaseProvider);

  // Verify if the hash already exist in the db and them return
  Future<int> insert(DriverEmergencyData row) async {
    Database db = await _databaseProvider.database;
    DriverEmergencyData driverEmergencyData =
        await queryAllRows();
    if (driverEmergencyData == null) {
      return await db.insert(
        table,
        toMap(row),
      );
    } else {
      return await update(row);
    }
  }

  // Return all rows
  Future<DriverEmergencyData> queryAllRows() async {
    Database db = await _databaseProvider.database;
    List<DriverEmergencyData> list = new List<DriverEmergencyData>();
    List<Map<String, dynamic>> result = await db.query(table);
    for (Map<String, dynamic> item in result) {
      list.add(fromMap(item));
    }
    return list.length > 0 ? list[0] : null;
  }

  // Count the amount of rows, just for debug
  Future<int> queryRowCount() async {
    Database db = await _databaseProvider.database;
    return Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $table"));
  }

  // Update the first row, because this is just for cash
  Future<int> update(DriverEmergencyData row) async {
    Database db = await _databaseProvider.database;
    return await db.update(table, toMap(row), where: "id = 1");
  }

  // Delete a row
  Future<int> delete() async {
    Database db = await _databaseProvider.database;
    return await db.delete(table, where: "id = 1");
  }

  Map<String, dynamic> toMap(DriverEmergencyData driverEmergencyData) {
    return <String, dynamic>{
      "name": driverEmergencyData.name ?? "",
      "relation": driverEmergencyData.relation ?? "",
      "cellNumber": driverEmergencyData.cellNumber ?? "",
    };
  }

  DriverEmergencyData fromMap(Map<String, dynamic> map) {
    return new DriverEmergencyData(
      name: map["name"],
      relation: map["relation"],
      cellNumber: map["cellNumber"],
    );
  }
}

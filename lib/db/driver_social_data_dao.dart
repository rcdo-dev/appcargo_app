import 'package:app_cargo/domain/driver_social_data/driver_social_data.dart';
import "package:sqflite/sqflite.dart";

import "database_provider.dart";

final String table = "driver_social_data";

class DriverSocialDataDAO {
  final DatabaseProvider _databaseProvider;

  DriverSocialDataDAO(this._databaseProvider);

  // Verify if the hash already exist in the db and them return
  Future<int> insert(DriverSocialData row) async {
    Database db = await _databaseProvider.database;
    DriverSocialData driverSocialData = await queryAllRows();
    if (driverSocialData == null) {
      return await db.insert(
        table,
        toMap(row),
      );
    } else {
      return await update(row);
    }
  }

  // Return all rows
  Future<DriverSocialData> queryAllRows() async {
    Database db = await _databaseProvider.database;
    List<DriverSocialData> list = new List<DriverSocialData>();
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
  Future<int> update(DriverSocialData row) async {
    Database db = await _databaseProvider.database;
    return await db.update(table, toMap(row), where: "id = 1");
  }

  // Delete a row
  Future<int> delete() async {
    Database db = await _databaseProvider.database;
    return await db.delete(table, where: "id = 1");
  }

  Map<String, dynamic> toMap(DriverSocialData driverSocialData) {
    return <String, dynamic>{
      "facebook": driverSocialData.facebook ?? "",
      "instagram": driverSocialData.instagram ?? "",
    };
  }

  DriverSocialData fromMap(Map<String, dynamic> map) {
    return new DriverSocialData(
      facebook: map["facebook"],
      instagram: map["instagram"],
    );
  }
}

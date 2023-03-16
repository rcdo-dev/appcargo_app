import 'package:app_cargo/domain/sync/sync.dart';
import "package:sqflite/sqflite.dart";

import "database_provider.dart";

final String table = "sync_table";

class SyncDAO {
  final DatabaseProvider _databaseProvider;

  SyncDAO(this._databaseProvider);

  Future<Sync> queryAllRows() async {
    Database db = await _databaseProvider.database;
    List<Sync> list = new List<Sync>();
    List<Map<String, dynamic>> result = await db.query(table);
    for (Map<String, dynamic> item in result) {
      list.add(fromMap(item));
    }
    
    if(list.length > 0)
      return list[0];
    else
      return null;
  }

  Future<int> queryRowCount() async {
    Database db = await _databaseProvider.database;
    return Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $table"));
  }

  Future<int> update(Sync row) async {
    Database db = await _databaseProvider.database;
    return await db.update(table, toMap(row), where: "id = 1");
  }

  Map<String, dynamic> toMap(Sync sync) {
    return <String, dynamic>{
      "declineReasonsListLastUpdate": sync.declineReasonsListLastUpdate,
      "voucherOwnershipLastUpdate": sync.voucherOwnershipLastUpdate,
    };
  }

  Sync fromMap(Map<String, dynamic> map) {
    return new Sync(
      declineReasonsListLastUpdate: map["declineReasonsListLastUpdate"],
      voucherOwnershipLastUpdate: map["voucherOwnershipLastUpdate"],
    );
  }
}

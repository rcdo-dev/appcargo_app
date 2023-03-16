import 'package:app_cargo/domain/address/address.dart';
import 'package:app_cargo/domain/address_summary/address_summary.dart';
import 'package:app_cargo/domain/city/city.dart';
import 'package:app_cargo/domain/freight_company_summary/freight_company_summary.dart';
import 'package:app_cargo/domain/freight_details/freight_details.dart';
import "package:app_cargo/domain/freight_summary/freight_summary.dart";
import 'package:app_cargo/domain/lat_lng/lat_lng.dart';
import 'package:app_cargo/domain/state/state.dart';
import 'package:app_cargo/domain/truck_trailer/truck_trailer.dart';
import "package:sqflite/sqflite.dart";

import "database_provider.dart";

final String table = "trailer_data";
final String hashColumn = "hash";

class TrailerDAO {
  final DatabaseProvider _databaseProvider;

  TrailerDAO(this._databaseProvider);

  Future<int> insert(TruckTrailer row) async {
    Database db = await _databaseProvider.database;
    TruckTrailer truckTrailer = await querySingleRow(row.hash);
    if (truckTrailer == null) {
      return await db.insert(
        table,
        toMap(row),
      );
    } else {
      return await update(row);
    }
  }


  Future<List<int>> insertAll(List<TruckTrailer> rows) async {
    List<int> result = new List<int>();
    for (TruckTrailer row in rows) {
      result.add(await insert(row));
    }
    return result;
  }

  Future<List<TruckTrailer>> queryAllRows() async {
    Database db = await _databaseProvider.database;
    return fromMapList(await db.query(table));
  }

  Future<TruckTrailer> querySingleRow(String hash) async {
    Database db = await _databaseProvider.database;
    List<Map<String, dynamic>> result = await await db
        .query(table, where: '$hashColumn = ?', whereArgs: [hash]);
    if (result.length == 0) return null;
    return fromMap(result[0]);
  }

  Future<int> queryRowCount() async {
    Database db = await _databaseProvider.database;
    return Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $table"));
  }

  Future<int> update(TruckTrailer row) async {
    Database db = await _databaseProvider.database;
    String hash = row.hash;
    return await db
        .update(table, toMap(row), where: "$hashColumn = ?", whereArgs: [hash]);
  }

  Future<int> delete(String hash) async {
    Database db = await _databaseProvider.database;
    return await db.delete(table, where: "$hashColumn = $hash");
  }

  Future<List<int>> deleteAll() async {
    List<TruckTrailer> trailers = await this.queryAllRows();
    List<int> resultDeleteAll = new List<int>();

    if (trailers != null) {
      for (TruckTrailer trailer in trailers) {
        resultDeleteAll.add(await this.delete(trailer.hash));
      }
    }
  
    return resultDeleteAll;
  }

  Map<String, dynamic> toMap(TruckTrailer truckTrailer) {
    return <String, dynamic>{
      "hash": truckTrailer.hash,
      "plate": truckTrailer.plate,
      "renavam": truckTrailer.renavam,
      "vin": truckTrailer.vin,
      "extras": truckTrailer.extras,
      "documentationPhotoUrl": truckTrailer.documentationPhotoUrl,
    };
  }

  TruckTrailer fromMap(Map<String, dynamic> map) {
    return new TruckTrailer(
      hash: map["hash"],
      plate: map["plate"],
      renavam: map["ranavam"],
      vin: map["vin"],
      extras: map["extras"],
      documentationPhotoUrl: map["documentationPhotoUrl"],
    );
  }

  List<TruckTrailer> fromMapList(List<dynamic> items) {
    List<TruckTrailer> trailers = new List<TruckTrailer>();

    for (Map<String, dynamic> item in items) {
      trailers.add(fromMap(item));
    }
  }
}

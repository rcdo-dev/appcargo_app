import 'package:app_cargo/domain/feight_proposal_decline_reasons/freight_proposal_decline_reasons.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'database_provider.dart';

final String table = 'decline_reasons';
final String hashColumn = 'hash';

class FreightProposalDeclineReasonDAO {
  final DatabaseProvider _databaseProvider;

  FreightProposalDeclineReasonDAO(this._databaseProvider);

  Future<int> insert(FreightProposalDeclineReason row) async {
    Database db = await _databaseProvider.database;
    FreightProposalDeclineReason declineReasons =
        await querySingleRow(row.hash);
    if (declineReasons == null) {
      return await db.insert(
        table,
        toMap(row),
      );
    } else {
      return await update(row);
    }
  }

  Future<List<int>> insertAll(List<FreightProposalDeclineReason> rows) async {
    List<int> result = new List<int>();
    for (FreightProposalDeclineReason row in rows) {
      result.add(await insert(row));
    }
    return result;
  }

  Future<List<FreightProposalDeclineReason>> queryAllRows() async {
    Database db = await _databaseProvider.database;
    List<FreightProposalDeclineReason> list =
        new List<FreightProposalDeclineReason>();
    List<Map<String, dynamic>> result = await db.query(table);
    for (Map<String, dynamic> item in result) {
      list.add(fromMap(item));
    }
    return list;
  }

  Future<FreightProposalDeclineReason> querySingleRow(String hash) async {
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

  Future<int> update(FreightProposalDeclineReason row) async {
    Database db = await _databaseProvider.database;
    String hash = row.hash;
    return await db
        .update(table, toMap(row), where: "$hashColumn = '$hash'");
  }

  Future<int> delete(String hash) async {
    Database db = await _databaseProvider.database;
    return await db.delete(table, where: "$hashColumn = ?", whereArgs: [hash]);
  }

  Future<List<int>> deleteAll(
      {List<FreightProposalDeclineReason> listDeclineReasons}) async {
    List<int> deleteResult = new List<int>();

    List<FreightProposalDeclineReason> listDeclineReasonsToBeDeleted =
        listDeclineReasons;

    if (listDeclineReasonsToBeDeleted == null)
      listDeclineReasonsToBeDeleted = await this.queryAllRows();

    for (FreightProposalDeclineReason refuseReason
        in listDeclineReasonsToBeDeleted)
      deleteResult.add(await this.delete(refuseReason.hash));

    return deleteResult;
  }

  Map<String, dynamic> toMap(
      FreightProposalDeclineReason freightProposalDeclineReason) {
    return <String, dynamic>{
      "hash": freightProposalDeclineReason.hash,
      "description": freightProposalDeclineReason.description,
    };
  }

  FreightProposalDeclineReason fromMap(Map<String, dynamic> map) {
    return new FreightProposalDeclineReason(
        hash: map["hash"], description: map["description"]);
  }
}

import 'package:app_cargo/domain/voucher_details/voucher_details.dart';
import "package:sqflite/sqflite.dart";

import "database_provider.dart";

final String table = "voucher_details";
final String hashColumn = "hash";

class VoucherDetailsDAO {
  final DatabaseProvider _databaseProvider;

  VoucherDetailsDAO(this._databaseProvider);

  // Verify if the hash already exist in the db and them return
  Future<int> insert(VoucherDetails row) async {
    Database db = await _databaseProvider.database;
    VoucherDetails voucherDetails = await querySingleRow(row.hash);
    if (voucherDetails == null) {
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
  Future<List<VoucherDetails>> queryAllRows() async {
    Database db = await _databaseProvider.database;
    List<VoucherDetails> list = new List<VoucherDetails>();
    List<Map<String, dynamic>> result = await db.query(table);
    for (Map<String, dynamic> item in result) {
      list.add(fromMap(item));
    }
    return list;
  }

  // Query for a hash and return the first value of the query
  Future<VoucherDetails> querySingleRow(String hash) async {
    Database db = await _databaseProvider.database;
    List<Map<String, dynamic>> result =
    await db.query(table, where: '$hashColumn = ?', whereArgs: [hash]);
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
  Future<int> update(VoucherDetails row) async {
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

  Map<String, dynamic> toMap(VoucherDetails voucherDetails) {
    return <String, dynamic>{
      "hash": voucherDetails.hash,
      "name": voucherDetails.name,
      "imageUrl": voucherDetails.imageUrl,
      "description": voucherDetails.description,
      "canAcquire": voucherDetails.canAcquire ? 1 : 0,
    };
  }

  VoucherDetails fromMap(Map<String, dynamic> map) {
    return new VoucherDetails(
      hash: map["hash"],
      name: map["name"],
      imageUrl: map["imageUrl"],
      description: map["description"],
      canAcquire: map["canAcquire"] == 0 ? false : true,
    );
  }
}
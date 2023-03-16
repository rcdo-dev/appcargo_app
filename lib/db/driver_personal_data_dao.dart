import 'dart:io';

import 'package:app_cargo/domain/bank/bank.dart';
import 'package:app_cargo/domain/bank_data/bank_data.dart';
import 'package:app_cargo/domain/driver_license/driver_license.dart';
import 'package:app_cargo/domain/driver_personal_data/driver_personal_data.dart';
import 'package:app_cargo/screens/settings/user_data/settings_payment.dart';
import "package:sqflite/sqflite.dart";

import "database_provider.dart";

final String table = "driver_personal_data";

class DriverPersonalDataDAO {
  final DatabaseProvider _databaseProvider;

  DriverPersonalDataDAO(this._databaseProvider);

  // Verify if the hash already exist in the db and them return
  Future<int> insert(DriverPersonalData row) async {
    Database db = await _databaseProvider.database;
    DriverPersonalData driverPersonalData = await queryAllRows();
    if (driverPersonalData == null) {
      return await db.insert(
        table,
        toMap(row),
      );
    } else {
      return await update(row);
    }
  }

  // Return all rows
  Future<DriverPersonalData> queryAllRows() async {
    Database db = await _databaseProvider.database;
    List<DriverPersonalData> list = new List<DriverPersonalData>();
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
  Future<int> update(DriverPersonalData row) async {
    Database db = await _databaseProvider.database;
    return await db.update(table, toMap(row), where: "id = 1");
  }

  // Delete a row
  Future<int> delete() async {
    Database db = await _databaseProvider.database;
    return await db.delete(table, where: "id = 1");
  }

  Map<String, dynamic> toMap(DriverPersonalData driverPersonalData) {
    return <String, dynamic>{
      "personalPhotoUrl": driverPersonalData.personalPhotoUrl,
      "alias": driverPersonalData.alias,
      "name": driverPersonalData.name,
      "nationalId": driverPersonalData.nationalId,
      "registry": driverPersonalData.registry,
      "birthDate": driverPersonalData.birthDate,
      "hasMope": (driverPersonalData.hasMope != null) ? (driverPersonalData.hasMope? 1 : 0) : 0,
      "hasMercoSulPermission": (driverPersonalData.hasMercoSulPermission != null) ? (driverPersonalData.hasMercoSulPermission? 1 : 0) : 0,
      "hasMEI": (driverPersonalData.hasMEI != null) ? (driverPersonalData.hasMEI ? 1 : 0) : 0,
      "driverLicenseNumber": driverPersonalData.driverLicense.number,
      "driverLicenseCategory":
          driverPersonalData.driverLicense.classification != null ? driverPersonalData.driverLicense.classification.uniqueName() : null,
      "driverLicenseExpirationDate":
          driverPersonalData.driverLicense.expirationDate,
      "rntrc": driverPersonalData.rntrc,
      "reference1": driverPersonalData.references.length > 0
          ? driverPersonalData.references[0]
          : "",
      "reference2": driverPersonalData.references.length > 1
          ? driverPersonalData.references[1]
          : "",
      "reference3": driverPersonalData.references.length > 2
          ? driverPersonalData.references[2]
          : "",
      "previousCompany1": driverPersonalData.previousFreightCompanies.length > 0
          ? driverPersonalData.previousFreightCompanies[0]
          : "",
      "previousCompany2": driverPersonalData.previousFreightCompanies.length > 1
          ? driverPersonalData.previousFreightCompanies[1]
          : "",
      "previousCompany3": driverPersonalData.previousFreightCompanies.length > 2
          ? driverPersonalData.previousFreightCompanies[2]
          : "",
      "bank":
          driverPersonalData.bank != null ? driverPersonalData.bank.code : "",
      "branch": driverPersonalData.branch,
      "account": driverPersonalData.account,
    };
  }

  DriverPersonalData fromMap(Map<String, dynamic> map) {
    return new DriverPersonalData(
      personalPhotoUrl: map["personalPhotoUrl"],
      alias: map["alias"],
      name: map["name"],
      nationalId: map["nationalId"],
      registry: map["registry"],
      birthDate: map["birthDate"],
      hasMope: map["hasMope"] == 0 ? false : true,
      hasMercoSulPermission: map["hasMercoSulPermission"] == 0 ? false : true,
      hasMEI: map["hasMEI"] == 0 ? false : true,
      driverLicense: new DriverLicense(
        number: map["driverLicenseNumber"],
        classification:
            DriverLicenseCategory.fromJson(map["driverLicenseCategory"]),
        expirationDate: map["driverLicenseExpirationDate"],
      ),
      rntrc: map["rntrc"],
      references: [
        map["reference1"],
        map["reference2"],
        map["reference3"],
      ],
      previousFreightCompanies: [
        map["previousCompany1"],
        map["previousCompany2"],
        map["previousCompany3"],
      ],
      bank: new Bank(code: map["bank"]),
      branch: map["branch"],
      account: map["account"],
    );
  }
}

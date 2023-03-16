import 'dart:core';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_migration/sqflite_migration.dart';

Future<Database> openDatabaseWithMigration(
    String path, MigrationConfig config) async {
  final migrator = Migrator(config);
  return await openDatabase(path,
      version: config.migrationScripts.length + 1,
      onCreate: migrator.executeInitialization,
      onUpgrade: migrator.executeMigration);
}

class Migrator {
  final MigrationConfig config;

  Migrator(this.config);

  Future<void> executeInitialization(Database db, int version) async {
    config.initializationScript
        .forEach((script) async => await db.execute(script));
    config.migrationScripts.forEach((script) async => await db.execute(script));
  }

  Future<void> executeMigration(
      Database db, int oldVersion, int newVersion) async {
    assert(oldVersion < newVersion,
        'The newVersion($newVersion) should always be greater than the oldVersion($oldVersion).');

    if (config.migrationScripts.length >= newVersion) {
      for (var i = oldVersion - 1; i < newVersion - 1; i++) {
        await db.execute(config.migrationScripts[i]);
      }
    }
  }
}

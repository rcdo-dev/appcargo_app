import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'migration_helper.dart' as prefix0;
import 'package:sqflite_migration/sqflite_migration.dart';

final String dbName = "AppCargo.db";

final config = MigrationConfig(
    initializationScript: initialScript, migrationScripts: migrations);

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Future<Database> get database async {
    return await openDatabase();
  }

  openDatabase() async {
    final databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    return await prefix0.openDatabaseWithMigration(path, config);
  }
}

final List<String> initialScript = [
  '''
  CREATE TABLE $proposalsTable (
      id INTEGER PRIMARY KEY,
      hash TEXT,
      code TEXT,
      fromCityHash TEXT,
      fromStateHash TEXT,
      fromCityName TEXT,
      fromStateAcronym TEXT,
      fromLat TEXT,
      fromLng TEXT,
      fromFormatted TEXT,
      toCityHash TEXT,
      toStateHash TEXT,
      toCityName TEXT,
      toStateAcronym TEXT,
      toLat TEXT,
      toLng TEXT,
      toFormatted TEXT,
      distanceInMeters TEXT,
      freightCoContact TEXT,
      weightInGrams TEXT,
      valueInCents TEXT,
      tollInCents TEXT,
      termInDays TEXT,
      paymentMethod TEXT,
      status TEXT,
      product TEXT,
      species TEXT,
      observations TEXT,
      freightCompanyHash TEXT,
      freightCompanyAccessCredentialHash TEXT,
      freightCompanyName TEXT,
      freightCompanyPhoto TEXT,
      freightCompanyRating TEXT,
      freightCompanyPositionInRanking TEXT,
      freightCompanyContact TEXT,
      freightCompanyCityHash TEXT,
      freightCompanyStateHash TEXT,
      freightCompanyCityName TEXT,
      freightCompanyStateAcronym TEXT,
      freightCompanyLat TEXT,
      freightCompanyLng TEXT,
      freightCompanyFormatted TEXT )
  ''',
  '''
  CREATE TABLE $currentTable (
      id INTEGER PRIMARY KEY,
      hash TEXT,
      code TEXT,
      fromCityHash TEXT,
      fromStateHash TEXT,
      fromCityName TEXT,
      fromStateAcronym TEXT,
      fromLat TEXT,
      fromLng TEXT,
      fromFormatted TEXT,
      toCityHash TEXT,
      toStateHash TEXT,
      toCityName TEXT,
      toStateAcronym TEXT,
      toLat TEXT,
      toLng TEXT,
      toFormatted TEXT,
      distanceInMeters TEXT,
      freightCoContact TEXT,
      weightInGrams TEXT,
      valueInCents TEXT,
      tollInCents TEXT,
      termInDays TEXT,
      paymentMethod TEXT,
      status TEXT,
      product TEXT,
      species TEXT,
      observations TEXT,
      freightCompanyHash TEXT,
      freightCompanyAccessCredentialHash TEXT,
      freightCompanyName TEXT,
      freightCompanyPhoto TEXT,
      freightCompanyRating TEXT,
      freightCompanyPositionInRanking TEXT,
      freightCompanyContact TEXT,
      freightCompanyCityHash TEXT,
      freightCompanyStateHash TEXT,
      freightCompanyCityName TEXT,
      freightCompanyStateAcronym TEXT,
      freightCompanyLat TEXT,
      freightCompanyLng TEXT,
      freightCompanyFormatted TEXT )
  ''',
  '''
  CREATE TABLE $historyTable (
      id INTEGER PRIMARY KEY,
      hash TEXT,
      code TEXT,
      fromCityHash TEXT,
      fromStateHash TEXT,
      fromCityName TEXT,
      fromStateAcronym TEXT,
      fromLat TEXT,
      fromLng TEXT,
      fromFormatted TEXT,
      toCityHash TEXT,
      toStateHash TEXT,
      toCityName TEXT,
      toStateAcronym TEXT,
      toLat TEXT,
      toLng TEXT,
      toFormatted TEXT,
      distanceInMeters TEXT,
      freightCoContact TEXT )
  ''',
  '''
  CREATE TABLE $declineReasons (
      id INTEGER PRIMARY KEY,
      hash TEXT,
      description TEXT )
  ''',
  '''
  CREATE TABLE $voucherInUse (
      id INTEGER PRIMARY KEY,
      hash TEXT,
      imageUrl TEXT,
      isInUse INTEGER,
      lastModified TEXT )
  ''',
  '''
	CREATE TABLE $voucherOverdue (
				id INTEGER PRIMARY KEY,
				hash TEXT,
				imageUrl TEXT,
				isInUse INTEGER
				lastModified TEXT )
  ''',
  '''
	CREATE TABLE $voucherDetails (
				id INTEGER PRIMARY KEY,
				hash TEXT,
				imageUrl TEXT,
				description TEXT,
				name TEXT,
				canAcquire INTEGER,
				lastModified TEXT )
	''',
  '''
	CREATE TABLE $syncTable (
				id INTEGER PRIMARY KEY,
				declineReasonsListLastUpdate TEXT,
				voucherOwnershipLastUpdate TEXT )
	''',
  '''
	CREATE TABLE $driverPersonalData (
				id INTEGER PRIMARY KEY,
				personalPhotoUrl TEXT,
				alias TEXT,
				name TEXT,
				nationalId TEXT,
				registry TEXT,
				birthDate TEXT,
				hasMope INTEGER,
				driverLicenseNumber TEXT,
				driverLicenseCategory TEXT,
				driverLicenseExpirationDate TEXT,
				rntrc TEXT,
				reference1 TEXT,
				reference2 TEXT,
				reference3 TEXT,
				previousCompany1 TEXT,
				previousCompany2 TEXT,
				previousCompany3 TEXT,
				bank TEXT,
				branch TEXT,
				account TEXT )
	''',
  '''
	CREATE TABLE $driverEmergencyData (
				id INTEGER PRIMARY KEY,
				name TEXT,
				relation TEXT,
				cellNumber TEXT )
	''',
  '''
	CREATE TABLE $driverSocialData (
				id INTEGER PRIMARY KEY,
				facebook TEXT,
				instagram TEXT )
	''',
  '''
	CREATE TABLE $driverContactData (
				id INTEGER PRIMARY KEY,
				cep TEXT,
				street TEXT,
				number TEXT,
				neighborhood TEXT,
				stateHash TEXT,
				stateAcronym TEXT,
				cityHash TEXT,
				cityName TEXT,
				formatted TEXT,
				cellNumber TEXT )
	''',
  '''
	CREATE TABLE $vehicleData (
				id INTEGER PRIMARY KEY,
				plate TEXT,
				renavam TEXT,
				vin TEXT,
				modelFipeId TEXT,
				makeFipeId TEXT,
				modelYear INTEGER,
				truckType TEXT,
				truckLoadType TEXT,
				hasPanicButton INTEGER,
				hasSiren INTEGER,
				hasDoorBlocker INTEGER,
				hasFifthWheelBlocker INTEGER,
				hasTrailerBlocker INTEGER,
				hasCarTracker INTEGER,
				carTrackerName TEXT,
				hasCarInsurance INTEGER,
				carInsuranceName TEXT,
				hasCarLocator INTEGER,
				carLocatorName TEXT,
				trackerType TEXT,
				truckFrontPhoto TEXT,
				truckPlatePhoto TEXT,
				truckLateralPhoto1 TEXT,
				truckLateralPhoto2 TEXT,
				truckRearPhoto TEXT,
				truckRearPlatePhoto TEXT)
	'''
];

final List<String> migrations = [
  '''
	INSERT INTO $syncTable (declineReasonsListLastUpdate, voucherOwnershipLastUpdate) VALUES ('20/09/2019', '20/09/2019')
  ''',
  '''
	DROP TABLE $vehicleData;
	''',
  '''
  CREATE TABLE $vehicleData(
	id INTEGER PRIMARY KEY,
				plate TEXT,
				renavam TEXT,
				vin TEXT,
				modelFipeId TEXT,
				makeFipeId TEXT,
				modelYear TEXT,
				truckType TEXT,
				truckLoadType TEXT,
				hasPanicButton INTEGER,
				hasSiren INTEGER,
				hasDoorBlocker INTEGER,
				hasFifthWheelBlocker INTEGER,
				hasTrailerBlocker INTEGER,
				hasCarTracker INTEGER,
				carTrackerName TEXT,
				hasCarInsurance INTEGER,
				carInsuranceName TEXT,
				hasCarLocator INTEGER,
				carLocatorName TEXT,
				trackerType TEXT,
				truckFrontPhoto TEXT,
				truckPlatePhoto TEXT,
				truckLateralPhoto1 TEXT,
				truckLateralPhoto2 TEXT,
				truckRearPhoto TEXT,
				truckRearPlatePhoto TEXT);
	''',
	'''
	CREATE TABLE $trailerData (
				id INTEGER PRIMARY KEY,
				plate TEXT,
				renavam TEXT,
				vin TEXT,
				extras TEXT,
				documentationPhotoUrl TEXT,
				hash TEXT);
	''',
	'''
	ALTER TABLE $driverPersonalData
							ADD COLUMN hasMercoSulPermission INTEGER;
	''',
  '''
  ALTER TABLE $vehicleData
              ADD COLUMN axles TEXT;
  ''',
  '''
	ALTER TABLE $driverPersonalData
							ADD COLUMN hasMEI INTEGER;
	'''
];

final String proposalsTable = 'proposals_freight';
final String currentTable = 'current_freight';
final String historyTable = 'history_freight';
final String declineReasons = 'decline_reasons';
final String voucherInUse = 'voucher_in_use';
final String voucherOverdue = 'voucher_overedue';
final String voucherDetails = 'voucher_details';
final String syncTable = 'sync_table';
final String driverPersonalData = 'driver_personal_data';
final String driverEmergencyData = 'driver_emergency_data';
final String driverSocialData = 'driver_social_data';
final String driverContactData = 'driver_contact_data';
final String vehicleData = 'vehicle_data';
final String trailerData = 'trailer_data';

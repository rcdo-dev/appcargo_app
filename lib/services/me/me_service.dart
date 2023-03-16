import 'dart:io';

import 'package:app_cargo/constants/default_api_errors.dart';
import 'package:app_cargo/db/current_freight_dao.dart';
import 'package:app_cargo/db/decline_reasons_dao.dart';
import 'package:app_cargo/db/driver_contact_data_dao.dart';
import 'package:app_cargo/db/driver_emergency_data_dao.dart';
import 'package:app_cargo/db/driver_personal_data_dao.dart';
import 'package:app_cargo/db/driver_social_data_dao.dart';
import 'package:app_cargo/db/freight_proposals_dao.dart';
import 'package:app_cargo/db/sync_dao.dart';
import 'package:app_cargo/db/vehicle_data_dao.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/driver_contact_data/driver_contact_data.dart';
import 'package:app_cargo/domain/driver_contact_update/driver_contact_update.dart';
import 'package:app_cargo/domain/driver_emergency_data/driver_emergency_data.dart';
import 'package:app_cargo/domain/driver_personal_data/driver_personal_data.dart';
import 'package:app_cargo/domain/driver_personal_data/driver_personal_data_photo.dart';
import 'package:app_cargo/domain/driver_social_data/driver_social_data.dart';
import 'package:app_cargo/domain/feight_proposal_decline_reasons/freight_proposal_decline_reasons.dart';
import 'package:app_cargo/domain/freight_company_summary/freight_company_summary.dart';
import 'package:app_cargo/domain/freight_company_summary_pageable/freight_company_summary_pageable.dart';
import 'package:app_cargo/domain/freight_details/freight_details.dart';
import 'package:app_cargo/domain/freight_summary/freight_summary.dart';
import 'package:app_cargo/domain/header_security/header_security.dart';
import 'package:app_cargo/domain/notification_configuration/notification_configuration.dart';
import 'package:app_cargo/domain/password_update/password_update.dart';
import 'package:app_cargo/domain/profile_summary/profile_summary.dart';
import 'package:app_cargo/domain/sync/sync.dart';
import 'package:app_cargo/domain/truck_data/change_truck_status.dart';
import 'package:app_cargo/domain/vehicle_data/vehicle_data.dart';
import 'package:app_cargo/domain/vehicle_data/vehicle_data_photo.dart';
import 'package:app_cargo/domain/vouchers/vouchers.dart';
import 'package:app_cargo/http/app_cargo_client.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:dio/dio.dart';

FreightCompanySummaryPageable _mapToListFreightCompanySummary(
    Map<String, dynamic> json) {
  return FreightCompanySummaryPageable.fromJson(json);
}

List<FreightProposalDeclineReason> _mapToFreightProposalDeclineReason(
    Map<String, dynamic> json) {
  List<FreightProposalDeclineReason> reasons =
      new List<FreightProposalDeclineReason>();
  for (Map<String, dynamic> reason in json["reasons"]) {
    reasons.add(FreightProposalDeclineReason.fromJson(reason));
  }
  return reasons;
}

HeaderSecurity _mapToDriverHeaderSecurity(Map<String, dynamic> json) {
  return HeaderSecurity.fromJson(json);
}

List<FreightSummary> _mapToFreightSummaryList(Map<String, dynamic> json) {
  List<FreightSummary> historic = new List<FreightSummary>();
  for (Map<String, dynamic> freight in json["data"]) {
    historic.add(FreightSummary.fromJson(freight));
  }
  return historic;
}

Vouchers _mapToVouchers(Map<String, dynamic> json) {
  return Vouchers.fromJson(json);
}

ProfileSummary _mapToProfileSummary(Map<String, dynamic> json) {
  return ProfileSummary.fromJson(json);
}

NotificationConfiguration _mapToNotificationConfiguration(
    Map<String, dynamic> json) {
  return NotificationConfiguration.fromJson(json);
}

Map<String, dynamic> _mapToGetAddressFromLatLong(Map<String, dynamic> json) {
  return <String, dynamic>{
    'stateAcronym': json["stateAcronym"] as String,
    'city': json["city"] as String,
    'cityName': json["cityName"] as String,
  };
}

class MeService {
  AppCargoClient _dioClient;

  // DAOs for app cache
  final FreightProposalsDAO _freightProposalsDAO =
      DIContainer().get<FreightProposalsDAO>();
  final CurrentFreightDAO _currentFreightDAO =
      DIContainer().get<CurrentFreightDAO>();
  final DriverPersonalDataDAO _driverPersonalDataDAO =
      DIContainer().get<DriverPersonalDataDAO>();
  final DriverEmergencyDataDAO _driverEmergencyDataDAO =
      DIContainer().get<DriverEmergencyDataDAO>();
  final DriverSocialDataDAO _driverSocialDataDAO =
      DIContainer().get<DriverSocialDataDAO>();
  final DriverContactDataDAO _driverContactDataDAO =
      DIContainer().get<DriverContactDataDAO>();
  final VehicleDataDAO _vehicleDataDAO = DIContainer().get<VehicleDataDAO>();
  final SyncDAO _syncDAO = DIContainer().get<SyncDAO>();
  final FreightProposalDeclineReasonDAO _declineReasonDAO =
      DIContainer().get<FreightProposalDeclineReasonDAO>();
  final FreightProposalDeclineReasonDAO _declineReasonsDAO =
      DIContainer().get<FreightProposalDeclineReasonDAO>();

  final ConfigurationService configurationService =
      DIContainer().get<ConfigurationService>();

  MeService(this._dioClient);

  /// Here we are trying to get all proposals and the current driver's freight.
  Future<ProfileSummary> getAllDriverData() {
    return this
        ._dioClient
        .get<ProfileSummary>(
          "/v2/me",
          _mapToProfileSummary,
        )
        .then(
      (ProfileSummary _profileSummary) {
        // If has a current freight save it in the DB
        if (_profileSummary.current != null) {
          _currentFreightDAO.insert(_profileSummary.current);
        }

        // If has freight proposals save it in the DB
        if (_profileSummary.proposals != null) {
          if (_profileSummary.proposals.length != 0) {
            print(FreightDetails.toJson(_profileSummary.proposals[0]));
            _freightProposalsDAO.insertAll(_profileSummary.proposals);
          }
        }

        // Cache all driver data for future use
        if (_profileSummary.personal != null) {
          _driverPersonalDataDAO.insert(_profileSummary.personal);
        }

        if (_profileSummary.social != null) {
          _driverSocialDataDAO.insert(_profileSummary.social);
        } else {
          _driverSocialDataDAO.insert(new DriverSocialData());
        }

        if (_profileSummary.emergency != null) {
          _driverEmergencyDataDAO.insert(_profileSummary.emergency);
        } else {
          _driverEmergencyDataDAO.insert(new DriverEmergencyData());
        }

        if (_profileSummary.contact != null) {
          _driverContactDataDAO.insert(_profileSummary.contact);
        } else {
          _driverContactDataDAO.insert(new DriverContactData());
        }

        // Caching the Driver's vehicle data
        if (_profileSummary.vehicle != null) {
          _vehicleDataDAO.insert(_profileSummary.vehicle);
        }

        updateSyncData(_profileSummary.declineReasonsListLastUpdate,
            _profileSummary.voucherOwnershipLastUpdate);

        return _profileSummary;
      },
    ).catchError((e) {
      throw e;
    });
  }

  /// Here we are trying to deactivate the driver's account, this may require a reason, but the working is in progress
  Future<void> deleteDriverAccount() => this._dioClient.delete("/v1/me");

  Future<dynamic> updatePassword(PasswordUpdate passwordUpdate) {
    return this
        ._dioClient
        .put(
          "/v1/me/password",
          data: PasswordUpdate.toJson(passwordUpdate),
        )
        .catchError((e) {
      throw e;
    });
  }

  Future<NotificationConfiguration> getNotificationConfiguration() {
    return this
        ._dioClient
        .get<NotificationConfiguration>(
          "/v1/me/notificationConfig",
          _mapToNotificationConfiguration,
        )
        .catchError((e) {
      throw e;
    });
  }

  Future<void> putNotificationConfiguration(
      NotificationConfiguration notificationConfiguration) {
    return this
        ._dioClient
        .put(
          "/v1/me/notificationConfig",
          data: NotificationConfiguration.toJson(notificationConfiguration),
        )
        .catchError((e) {
      throw e;
    });
  }

  Future<void> updateContactData(DriverContactUpdate driverContactUpdate) {
    return this
        ._dioClient
        .put(
          "/v1/me/contactData",
          data: DriverContactUpdate.toJson(driverContactUpdate),
        )
        .then((voidObject) {
      if (driverContactUpdate.contact != null)
        this._driverContactDataDAO.insert(driverContactUpdate.contact);
      if (driverContactUpdate.emergency != null)
        this._driverEmergencyDataDAO.insert(driverContactUpdate.emergency);
      if (driverContactUpdate.social != null)
        this._driverSocialDataDAO.insert(driverContactUpdate.social);
    }).catchError((error) {
      throw error;
    });
  }

  Future<dynamic> updatePersonalData(DriverPersonalData driverPersonalData) {
    return this
        ._dioClient
        .putMultipart(
          "/v1/me/personalData",
          data: DriverPersonalData.toJson(driverPersonalData),
          files: driverPersonalData.files,
          mapper: DriverPersonalDataPhoto.fromJson,
          options: Options(
            contentType: ContentType.parse("multipart/form-data;charset=UTF-8"),
          ),
        )
        .then((dynamic response) {
      if (response is DriverPersonalDataPhoto) {
        if (response != null)
          driverPersonalData = response
              .updatePersonalDataWithReceivedPhotoUrl(driverPersonalData);

        this._driverPersonalDataDAO.insert(driverPersonalData);
      } else {
        return response;
      }
    }).catchError((e) {
      throw e;
    });
  }

  Future<void> updateVehicleData(VehicleData vehicleData) {
    return this
        ._dioClient
        .putMultipart(
          "/v2/me/vehicleData",
          data: VehicleData.toJson(vehicleData),
          files: vehicleData.truckPhotos.files,
          mapper: VehicleDataPhoto.fromJson,
          options: Options(
            contentType: ContentType.parse("multipart/form-data;charset=UTF-8"),
          ),
        )
        .then((VehicleDataPhoto response) {
      if (response != null)
        vehicleData =
            response.updateVehicleDataWithReceivedPhotosUrl(vehicleData);

      this._vehicleDataDAO.insert(vehicleData);
    }).catchError((error) {
      throw error;
    });
  }

  Future<void> updateTruckStatus(
    ChangeTruckStatus changeTruckStatus,
  ) {
    return configurationService.truckStatusLastUpdate
        .then((truckStatusLastUpdate) {
//      if(truckStatusLastUpdate == null){
//        configurationService.setTruckStatusLastUpdate();
//      }else{
//        DateTime truckStatusLastUpdateDate = DateTime.parse(truckStatusLastUpdate);
//        DateTime now = DateTime.now();
//        if((now.millisecondsSinceEpoch - truckStatusLastUpdateDate.millisecondsSinceEpoch) < (1 * 60 * 60 * 1000))
//          throw [ALREADY_UPDATED_TRUCK_STATUS_TODAY];
//      }

      return this._dioClient.put(
            "/v1/me/status",
            data: ChangeTruckStatus.toJson(
              changeTruckStatus,
            ),
          );
    }).catchError((e) {
      throw e;
    });
  }

  Future<Vouchers> getVouchers() {
//    return Future.value(new Vouchers(overdue: [new VoucherSummary(hash: "hash", imageUrl: "")], vouchers: [new VoucherSummary(hash: "hash", imageUrl: "")],));
    return this
        ._dioClient
        .get("/v1/me/vouchers", _mapToVouchers)
        .catchError((e) {
      throw e;
    });
  }

  Future<List<FreightSummary>> getFreightHistory(int page, int pageSize) {
    return this
        ._dioClient
        .get<List<FreightSummary>>(
            "/v1/me/freights?page=$page&pageSize=$pageSize",
            _mapToFreightSummaryList)
        .catchError((e) {
      throw e;
    });
  }

  Future<List<FreightCompanySummary>> getRecentlyFrightCompanies() {
    return this
        ._dioClient
        .get<FreightCompanySummaryPageable>(
          "/v1/me/lastFreightCompanies",
          _mapToListFreightCompanySummary,
        )
        .then((response) {
      if (response is FreightCompanySummaryPageable) return response.data;

      throw [UNDEFINED_FREIGHT_COMPANY_SEARCH_ERROR];
    }).catchError((e) {
      throw e;
    });
  }

  // Get the driver's personal data
  Future<DriverPersonalData> getPersonalData() {
    // Try get the data from the db if can't get from db fallback to the server
    return _driverPersonalDataDAO
        .queryAllRows()
        .then((DriverPersonalData _queryResult) async {
      if (_queryResult != null) {
        return _queryResult;
      } else {
        ProfileSummary _profileSummary = await getAllDriverData();
        return _profileSummary.personal;
      }
    }).catchError((e) {
      throw e;
    });
  }

  // Get the driver's vehicle data
  Future<VehicleData> getVehicleData() {
    // Try get the data from the db if can't get from db fallback to the server
    return _vehicleDataDAO
        .queryAllRows()
        .then((VehicleData _queryResult) async {
      if (_queryResult != null) {
        return _queryResult;
      } else {
        ProfileSummary _profileSummary = await getAllDriverData();
        return _profileSummary.vehicle;
      }
    }).catchError((e) {
      throw e;
    });
  }

  // Get the driver's contact data
  Future<DriverContactUpdate> getContactUpdateData() async {
    // Try get the data from the db if can't get from db fallback to the server
    DriverContactData driverContactData =
        await _driverContactDataDAO.queryAllRows();
    DriverSocialData driverSocialData =
        await _driverSocialDataDAO.queryAllRows();
    DriverEmergencyData driverEmergencyData =
        await _driverEmergencyDataDAO.queryAllRows();

    return new DriverContactUpdate(
        social: driverSocialData,
        emergency: driverEmergencyData,
        contact: driverContactData);
  }

  // Get the driver's quantity of proposals
  Future<int> getProposalsQuantity() {
    // Try get the data from the db if can't get from db fallback to the server
    return _freightProposalsDAO.queryRowCount().then((value) {
      if (value != null) {
        return value;
      } else {
        return 0;
      }
    }).catchError((error) {
      throw error;
    });
  }

  void updateSyncData(String refuseReason, String voucherOwnership) async {
    // Compare the received sync data and verify if it needs to make the request again
    Sync responseSyncData = new Sync(
        declineReasonsListLastUpdate: refuseReason,
        voucherOwnershipLastUpdate: voucherOwnership);
    Sync dbSyncData = await _syncDAO.queryAllRows();

    if (dbSyncData == null) {
      _syncDAO.update(responseSyncData);
      _declineReasonDAO.deleteAll();
      getDeclineReasons();
      return;
    }

    List<String> dbLastRefuseReasonUpdateDateDb =
        dbSyncData.declineReasonsListLastUpdate.split("/");

    DateTime dbLastRefuseReasonUpdateDate = new DateTime(
        int.parse(dbLastRefuseReasonUpdateDateDb[2]),
        int.parse(dbLastRefuseReasonUpdateDateDb[1]),
        int.parse(dbLastRefuseReasonUpdateDateDb[0]));

    List<String> lastRefuseReasonDateResponse = refuseReason.split("/");

    DateTime lastRefuseReasonUpdateDate = new DateTime(
        int.parse(lastRefuseReasonDateResponse[2]),
        int.parse(lastRefuseReasonDateResponse[1]),
        int.parse(lastRefuseReasonDateResponse[0]));

    // If the refuse reasons in the db are outdated clean the db and to the request again
    if (dbLastRefuseReasonUpdateDate.isBefore(lastRefuseReasonUpdateDate)) {
      _syncDAO.update(responseSyncData);
      _declineReasonDAO.deleteAll();
      getDeclineReasons();
    }

    // TODO: Here we need to do the same thing but for voucher ownership class
    //
    //
  }

  Future<List<FreightProposalDeclineReason>> getDeclineReasons() {
    return this
        ._dioClient
        .get<List<FreightProposalDeclineReason>>(
            "/v1/refusalReasons", _mapToFreightProposalDeclineReason)
        .then((List<FreightProposalDeclineReason> listRefuseReason) {
      _declineReasonsDAO.insertAll(listRefuseReason);

      return listRefuseReason;
    }).catchError((e) {
      throw e;
    });
  }

  Future<HeaderSecurity> getDriverSecurityHeader() {
    return this
        ._dioClient
        .get<HeaderSecurity>(
            "/v1/getChatSecurityHeader", _mapToDriverHeaderSecurity)
        .then((header) {
      return header;
    }).catchError((e) => {throw e});
  }

  Future<Map<String, dynamic>> getAddressByLatLong(double lat, double lng) {
    return this._dioClient.get(
        "/v1/getCityByCoordinates", _mapToGetAddressFromLatLong,
        queryParameters: {
          'lat': lat,
          'lng': lng,
        });
  }
}

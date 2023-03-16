import 'package:app_cargo/db/current_freight_dao.dart';
import 'package:app_cargo/db/decline_reasons_dao.dart';
import 'package:app_cargo/db/driver_contact_data_dao.dart';
import 'package:app_cargo/db/driver_emergency_data_dao.dart';
import 'package:app_cargo/db/driver_personal_data_dao.dart';
import 'package:app_cargo/db/driver_social_data_dao.dart';
import 'package:app_cargo/db/freight_proposals_dao.dart';
import 'package:app_cargo/db/trailer_dao.dart';
import 'package:app_cargo/db/vehicle_data_dao.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/header_security/header_security.dart';
import 'package:app_cargo/domain/notification_configuration/notification_configuration.dart';
import 'package:app_cargo/domain/version/app_version.dart';
import 'package:app_cargo/http/app_cargo_client.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info/package_info.dart';
import 'dart:convert';

class ConfigurationService {
  static const String _notifyNearbyRequests = 'notifyNearbyRequests';
  static const String _notifyCompanyContact = 'notifyCompanyContact';
  static const String _notifyCargoClubOffers = 'notifyCargoClubOffers';
  static const String _notifyOfNewRequests = 'notifyOfNewRequests';
  static const String _darkModePreferred = 'darkModePreferred';
  static const String _accessToken = 'accessToken';
  static const String _lastTruckStatusUpdate = 'lastTruckStatusUpdate';
  static const String _driverHash = 'driverHash';
  static const String _luckyNumber = 'luckyNumber';
  static const String _introSlider = 'introSlider';
  static const String _securityHeader = '_securityHeader';
  static const String _isPremium = '_isPremium';
  static const String _fcmToken = 'fcmToken';
  static const String _checkToolTip = 'checkToolTip';

  AppCargoClient _dioClient;
  final DriverPersonalDataDAO _driverPersonalDataDAO = DIContainer().get<DriverPersonalDataDAO>();
  final VehicleDataDAO _vehicleDataDAO = DIContainer().get<VehicleDataDAO>();
  final DriverContactDataDAO _driverContactDataDAO = DIContainer().get<DriverContactDataDAO>();
  final DriverSocialDataDAO _driverSocialDataDAO = DIContainer().get<DriverSocialDataDAO>();
  final DriverEmergencyDataDAO _driverEmergencyDataDAO = DIContainer().get<DriverEmergencyDataDAO>();
  final CurrentFreightDAO _currentFreightDAO = DIContainer().get<CurrentFreightDAO>();
  final FreightProposalsDAO _freightProposalsDAO = DIContainer().get<FreightProposalsDAO>();
  final FreightProposalDeclineReasonDAO _freightProposalDeclineReasonDAO = DIContainer().get<FreightProposalDeclineReasonDAO>();
  final TrailerDAO _trailerDAO = DIContainer().get<TrailerDAO>();

  bool get debug => true;

  ConfigurationService(this._dioClient);

  /// Get the newest notification configuration available
  Future<dynamic> getNotificationConfiguration() async {
    String accessToken = await this.accessToken;
    return this
        ._dioClient
        .get<NotificationConfiguration>(
          "/v1/me/notificationConfig",
          _mapToNotificationConfiguration,
          options: Options(
            headers: {"X-Access-Token": accessToken},
          ),
        )
        .then(
      (notificationConfiguration) {
        setNotificationConfiguration(notificationConfiguration);
        return notificationConfiguration;
      },
    );
  }

  /// Update the driver's notification configuration
  Future<dynamic> updateNotificationConfiguration(NotificationConfiguration notificationConfiguration) {
    return this
        ._dioClient
        .put(
          "/v1/me/notificationConfig",
          data: NotificationConfiguration.toJson(notificationConfiguration),
        )
        .then((voidObject) {
      setNotificationConfiguration(notificationConfiguration);
    });
  }

  /// Update the driver's notification configuration
  Future<dynamic> validateAppVersion() async {
    return this._dioClient.post(
          "/version",
          null,
          data: AppVersion.toJson(new AppVersion(version: await appVersion)),
        );
  }

  Future<String> get appVersion async {
    PackageInfo info = await PackageInfo.fromPlatform();
    return info.version;
  }

  Future<bool> get notifyNearbyRequests async {
    return _getIfExistsElseDefault<bool>(_notifyNearbyRequests, true);
  }

  void setCheckToolTip(List<String> value) {
    SharedPreferences.getInstance().then((SharedPreferences sharedPrefs) => sharedPrefs.setStringList(_checkToolTip, value));
  }

  Future<List<String>> get checkToolTip async {
    var sharedPrefs = await SharedPreferences.getInstance();
    if (sharedPrefs.containsKey(_checkToolTip)) {
      return sharedPrefs.getStringList(_checkToolTip);
    }
    return <String>[];
  }

  void setNotifyNearbyRequests(bool val) {
    SharedPreferences.getInstance().then((SharedPreferences sharedPrefs) => sharedPrefs.setBool(_notifyNearbyRequests, val));
  }

  Future<bool> get notifyCompanyContact async {
    return _getIfExistsElseDefault<bool>(_notifyCompanyContact, true);
  }

  void setNotifyCompanyContact(bool val) {
    SharedPreferences.getInstance().then((SharedPreferences sharedPrefs) => sharedPrefs.setBool(_notifyCompanyContact, val));
  }

  Future<bool> get notifyCargoClubOffers async {
    return _getIfExistsElseDefault<bool>(_notifyCargoClubOffers, true);
  }

  void setNotifyCargoClubOffers(bool val) {
    SharedPreferences.getInstance().then((SharedPreferences sharedPrefs) => sharedPrefs.setBool(_notifyCargoClubOffers, val));
  }

  Future<bool> get notifyOfNewRequests async {
    return _getIfExistsElseDefault<bool>(_notifyOfNewRequests, true);
  }

  void setNotifyOfNewRequests(bool val) {
    SharedPreferences.getInstance().then((SharedPreferences sharedPrefs) => sharedPrefs.setBool(_notifyOfNewRequests, val));
  }

  Future<bool> get darkModePreferred async {
    return _getIfExistsElseDefault<bool>(_darkModePreferred, false);
  }

  void setDarkModePreferred(bool val) {
    SharedPreferences.getInstance().then((SharedPreferences sharedPrefs) => sharedPrefs.setBool(_darkModePreferred, val));
  }

  /// Define se o motorista é Premium ou não.
  void setIsPremium(bool val) {
    SharedPreferences.getInstance().then(
      (SharedPreferences sharedPrefs) => sharedPrefs.setBool(
        _isPremium,
        val,
      ),
    );
  }

  /// Por padrão todo motorista não é Premium.
  Future<bool> get isPremium async {
    return _getIfExistsElseDefault(_isPremium, false);
  }

  /// Armazena o token do dispositivo do Firebase Cloud Messaging.
  void setFcmTokenDevice(String val) {
    SharedPreferences.getInstance().then(
      (SharedPreferences sharedPrefs) => sharedPrefs.setString(
        _fcmToken,
        val,
      ),
    );
  }

  /// Retorna o token do dispositivo do Firebase Cloud Messaging.
  Future<String> get fcmTokenDevice async {
    return _getIfExistsElseDefault(
      _fcmToken,
      '',
    );
  }

  Future<T> _getIfExistsElseDefault<T>(String key, T val) async {
    var sharedPrefs = await SharedPreferences.getInstance();
    if (sharedPrefs.containsKey(key)) {
      return sharedPrefs.get(key);
    }
    return val;
  }

  Future<T> _getSecurityHeaderIfExistsElseDefault<T>(String key, T val) async {
    var sharedPrefs = await SharedPreferences.getInstance();
    if (sharedPrefs.containsKey(key)) {
      return sharedPrefs.get(key);
    }
    return val;
  }

  Future<bool> setAccessToken(String accessToken) async {
    var sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.setString(_accessToken, accessToken);
  }

  Future<bool> setHeaderSecurity(HeaderSecurity headerSecurity) async {
    var sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.setString(_securityHeader, jsonEncode(HeaderSecurity.toJson(headerSecurity)));
  }

  Future<void> deleteAccessToken() async {
    var sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.remove(_accessToken);
  }

  Future<String> get accessToken {
    return _getIfExistsElseDefault(_accessToken, null);
  }

  Future<String> get securityHeader {
    return _getSecurityHeaderIfExistsElseDefault(_securityHeader, null);
  }

  Future<HeaderSecurity> getSecurityHeaderInstance() async {
    return HeaderSecurity.fromJson(json.decode(await this.securityHeader));
  }

  Future<bool> setDriverHash(String driverHash) async {
    var sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.setString(_driverHash, driverHash);
  }

  Future get driverHash {
    return _getIfExistsElseDefault(_driverHash, null);
  }

  Future<bool> setLuckyNumber(int luckyNumber) async {
    var sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.setInt(_luckyNumber, luckyNumber);
  }

  Future<int> get luckyNumber {
    return _getIfExistsElseDefault(_luckyNumber, null);
  }

  Future<dynamic> driverRevalidatedLuckyNumber() {
    return this._dioClient.post('/v1/revalidateLuckyNumber', null);
  }

  void setNotificationConfiguration(NotificationConfiguration notificationConfiguration) {
    setNotifyCargoClubOffers(notificationConfiguration.notifyCargoClubOffers);
    setNotifyOfNewRequests(notificationConfiguration.notifyNewRequests);
    setNotifyNearbyRequests(notificationConfiguration.notifyNearbyRequests);
    setNotifyCompanyContact(notificationConfiguration.notifyCompanyContact);
  }

  NotificationConfiguration _mapToNotificationConfiguration(Map<String, dynamic> json) {
    return NotificationConfiguration.fromJson(json);
  }

  Future<void> cleanDbBeforeLogin() async {
    await _driverPersonalDataDAO.delete();
    await _vehicleDataDAO.delete();
    await _driverContactDataDAO.delete();
    await _driverEmergencyDataDAO.delete();
    await _driverSocialDataDAO.delete();
    await _freightProposalsDAO.deleteAll();
    await _currentFreightDAO.delete();
    await _freightProposalDeclineReasonDAO.deleteAll();
    await _trailerDAO.deleteAll();
    return;
  }

  Future<NotificationConfiguration> getAllNotificationConfiguration() async {
    bool notifyNearbyRequests = await this.notifyNearbyRequests;
    bool notifyCompanyContact = await this.notifyCompanyContact;
    bool notifyCargoClubOffers = await this.notifyCargoClubOffers;
    bool notifyNewRequests = await this.notifyOfNewRequests;

    return new NotificationConfiguration(
      notifyCargoClubOffers: notifyCargoClubOffers,
      notifyCompanyContact: notifyCompanyContact,
      notifyNearbyRequests: notifyNearbyRequests,
      notifyNewRequests: notifyNewRequests,
    );
  }

  Future<bool> setTruckStatusLastUpdate() async {
    var sharedPrefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    return sharedPrefs.setString(_lastTruckStatusUpdate, now.toIso8601String());
  }

  Future<void> deleteTruckStatusLastUpdate() async {
    var sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.remove(_lastTruckStatusUpdate);
  }

  Future<String> get truckStatusLastUpdate {
    return _getIfExistsElseDefault(_lastTruckStatusUpdate, null);
  }

  Future<bool> setNewRegistrationModalShow({int newValue = 4}) async {
    var sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.setString("newRegistrationModalShow", newValue.toString());
  }

  Future<void> deleteNewRegistrationModalShow() async {
    var sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.remove("newRegistrationModalShow");
  }

  Future<int> get newRegistrationModalShow async {
    String value = await _getIfExistsElseDefault("newRegistrationModalShow", null);
    if (value != null) {
      return int.parse(value);
    } else {
      setNewRegistrationModalShow();
      return 1;
    }
  }

  Future<bool> setIntroSlider(String newValue) async {
    var sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.setString(_introSlider, newValue);
  }

  Future<String> get introSlider async {
    String value = await _getIfExistsElseDefault(_introSlider, null);

    if (value == null) setIntroSlider("intro");

    return value;
  }
}

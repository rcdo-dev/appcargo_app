import 'dart:convert';

import 'package:flutter_background_geolocation/flutter_background_geolocation.dart';
import 'package:intl/intl.dart';
import 'package:app_cargo/http/app_cargo_client.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:app_cargo/domain/location/location.dart' as domain;

import '../../di/container.dart';
import '../config/config_service.dart';

class LocationService {
  bool _isMoving;
  bool _enabled;
  String _motionActivity;
  String _odometer;
  String _content;

  AppCargoClient _dioClient;

  final ConfigurationService configService =
      DIContainer().get<ConfigurationService>();

  ////
  // For pretty-printing location JSON. Not a requirement of flutter_background_geolocation.
  //
  JsonEncoder encoder = new JsonEncoder.withIndent("     ");

  //
  ////

  LocationService(this._dioClient);

  void initBackgroundMonitoring() {
    // 1.  Listen to events (See docs for all 12 available events).
    bg.BackgroundGeolocation.onLocation(_onLocation);
    bg.BackgroundGeolocation.onMotionChange(_onMotionChange);
    bg.BackgroundGeolocation.onActivityChange(_onActivityChange);
    bg.BackgroundGeolocation.onProviderChange(_onProviderChange);
    bg.BackgroundGeolocation.onConnectivityChange(_onConnectivityChange);

    // 2.  Configure the plugin
    bg.BackgroundGeolocation.ready(bg.Config(
      desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
      distanceFilter: 5000.0,
      // 5 KM
      stopOnTerminate: false,
      startOnBoot: true,
      schedule: ['1-7 00:10-23:50'],
      debug: false,
//            logLevel: bg.Config.LOG_LEVEL_VERBOSE,
      reset: true,
      locationAuthorizationRequest: 'Always',
      backgroundPermissionRationale: PermissionRationale(
          title:
              "Permitir que o AppCargo acesse o local deste dispositivo em segundo plano?",
          message:
              "Para rastrear sua atividade em segundo plano, ative a permissão de localização Permitir Sempre",
          positiveAction: "Alterar para Permitir Sempre",
          negativeAction: "Cancelar"),
    )).then((bg.State state) {
      if (!state.enabled) {
        bg.BackgroundGeolocation.start().then((bg.State state) {
          print('[start] success $state');

          _enabled = state.enabled;
          _isMoving = state.isMoving;
        });

        bg.BackgroundGeolocation.startSchedule().then((bg.State state) {
          if (!state.enabled) {
            _enabled = state.enabled;
            _isMoving = state.isMoving;
          }
        });
      }
    });
    bg.BackgroundGeolocation.changePace(true);
  }

  //
  // Event handlers
  //

  void _onLocation(bg.Location location) {
    print('[location] - $location');

    String odometerKM = (location.odometer / 1000.0).toStringAsFixed(1);

    try {
      var now = new DateTime.now();
      String instant = new DateFormat("dd/MM/yyyy hh:mm:ss").format(now);
      putDriverLocation(new domain.Location(
          instant,
          location.coords.latitude,
          location.coords.longitude,
          location.coords.accuracy,
          location.battery.level,
          double.parse(odometerKM),
          location.isMoving));
    } catch (ignore) {}
  }

  void _onMotionChange(bg.Location location) {
    print('[motionchange] - $location');
  }

  void _onActivityChange(bg.ActivityChangeEvent event) {
    print('[activitychange] - $event');

    _motionActivity = event.activity;
  }

  void _onProviderChange(bg.ProviderChangeEvent event) {
    print('$event');

    _content = encoder.convert(event.toMap());
  }

  void _onConnectivityChange(bg.ConnectivityChangeEvent event) {
    print('$event');
  }

  Future<bool> putDriverLocation(domain.Location location) async {
    var accessToken = await configService.accessToken;
    // Send location only to logged users.
    if (null != accessToken) {
      return this
          ._dioClient
          .put("/v1/me/location", data: domain.Location.toJson(location))
          .then((value) {
        return true;
      }).catchError((ignore) {});
    }
  }

  // Get current location
  Future<Location> getCurrentLocation() async {
    return BackgroundGeolocation.getCurrentPosition(
      timeout: 5,
      // 30 second timeout to fetch location
      maximumAge: 20000,
      // Accept the last-known-location if not older than 5000 ms.
      desiredAccuracy: 20,
      // Try to fetch a location with an accuracy of `10` meters.
      samples: 2,
      // How many location samples to attempt.
      extras: {
        // [Optional] Attach your own custom meta-data to this location.  This meta-data will be persisted to SQLite and POSTed to your server
        "foo": "bar"
      },
    );
  }

  Future<bool> isLocalizationPermissionDenied() async {
    try {
      int status = await BackgroundGeolocation.requestPermission();
      if (status == ProviderChangeEvent.AUTHORIZATION_STATUS_DENIED) {
        return true;
      }
    } catch (error) {
      print("[requestPermission] DENIED: $error");
      return true;
    }
    return false;
  }
}

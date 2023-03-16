import 'package:app_cargo/domain/driver_sign_up/driver_sign_up.dart';

import 'package:app_cargo/domain/login_response/login_response.dart';

import 'driver_service.dart';

abstract class DriverMockService implements DriverService {
  @override
  Future<LoginResponse> signUp(DriverSignUp driver) {
    return Future.delayed(
        Duration(seconds: 1),
        () => new LoginResponse(
            accessToken: "96f02c01-eb87-463b-8f08-b3ad3e30ae1d"));
  }
}

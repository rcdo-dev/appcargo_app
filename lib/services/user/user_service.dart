import 'package:app_cargo/domain/login_response/login_response.dart';
import 'package:app_cargo/http/app_cargo_client.dart';

import '../notification/notification_service.dart';

LoginResponse _mapToLoginResponse(Map<String, dynamic> json) {
  return LoginResponse.fromJson(json);
}

class UserService {
  AppCargoClient _dioClient;
  NotificationService _notificationService;

  UserService(this._dioClient, this._notificationService);

  Future<dynamic> login(String login, String password) async {
    String token = await _notificationService.getDeviceToken();

    return this._dioClient.post<dynamic>(
      "/v1/login",
      _mapToLoginResponse,
      data: {
        'login': login,
        'password': password,
        'fcmToken': token,
      },
    );
  }

  Future<dynamic> loginV2(String plate, String birthDate) async {
    String token = await _notificationService.getDeviceToken();

    return this._dioClient.post<dynamic>(
      "/v2/login",
      _mapToLoginResponse,
      data: {
        'plate': plate,
        'birthDate': birthDate,
        'fcmToken': token,
      },
    );
  }

  Future<dynamic> loginV3(String plate, String birthDate, {String cpf}) async {
    String token = await _notificationService.getDeviceToken();

    return this._dioClient.post<dynamic>(
      "/v3/login",
      _mapToLoginResponse,
      data: {
        'plate': plate,
        'birthDate': birthDate,
        'fcmToken': token,
        'cpf': cpf,
      },
    );
  }
}

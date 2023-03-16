import 'package:app_cargo/domain/login_response/login_response.dart';
import 'package:app_cargo/services/user/user_service.dart';

class UserMockService implements UserService {
  @override
  Future<LoginResponse> login(String login, String password) {
    return Future.delayed(
        Duration(seconds: 1),
        () => new LoginResponse(
            accessToken: "72543da6-b7ad-11e9-a2a3-2a2ae2dbcce4"));
  }

  @override
  Future<LoginResponse> loginV2(String login, String password) {
    return Future.delayed(
        Duration(seconds: 1),
        () => new LoginResponse(
            accessToken: "72543da6-b7ad-11e9-a2a3-2a2ae2dbcce4"));
  }

  @override
  Future loginV3(String plate, String birthDate, {String cpf}) {
    return Future.delayed(
        Duration(seconds: 1),
        () => new LoginResponse(
            accessToken: "72543da6-b7ad-11e9-a2a3-2a2ae2dbcce4"));
  }
}

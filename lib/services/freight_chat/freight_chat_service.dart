import 'dart:convert';
import 'dart:io';

import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/header_security/header_security.dart';
import 'package:app_cargo/domain/new_freight/driver_threads.dart';
import 'package:app_cargo/domain/new_freight/message/media/media.dart';
import 'package:app_cargo/domain/new_freight/message/thread_message.dart';
import 'package:app_cargo/domain/thread_freight_summary/thread_freight_summary.dart';
import 'package:app_cargo/http/api_error.dart';
import 'package:app_cargo/http/app_cargo_client.dart';
import 'package:app_cargo/http/freight_chat_client.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:app_cargo/services/freight_chat/freight_chat_map_helper.dart';
import 'package:dio/dio.dart';

class FreightChatService {
  FreightChatClient _freightClient;
  AppCargoClient _dioClient;

  FreightChatService(
    this._freightClient,
    this._dioClient,
  );

  final ConfigurationService configurationService =
      DIContainer().get<ConfigurationService>();

  Future<Media> uploadFile(File file) {
    return this
        ._dioClient
        .postMultipart(
          '/v1/upload',
          mapper: Media.fromJson,
          files: {
            'file': file,
          },
          options: Options(
            contentType: ContentType.parse("multipart/form-data;charset=UTF-8"),
          ),
        )
        .then((response) {
      if (response is Media) {
        return response;
      } else {
        return null;
      }
    }).catchError((e) {
      print(e);
      throw e;
    });
  }

  Future<List<DriverThreads>> getDriverThreads() async {
    HeaderSecurity headerSecurity =
        await configurationService.getSecurityHeaderInstance();

    return _freightClient
        .get(
      "/${headerSecurity.hash}/threads",
      FreightChatMapHelper.mapToDriverThreads,
      options: Options(
        headers: {
          "newgo-security": jsonEncode(HeaderSecurity.toJson(headerSecurity))
        },
      ),
    )
        .then(
      (listThreads) async {
        List<DriverThreads> threads = List<DriverThreads>();
        for (DriverThreads thread in listThreads) {
          thread.threadFreightSummary =
              await getFreightDataFromAppCargo(thread.reference);
          // thread.threadFreightSummary = await getFreightDataFromAppCargo(
          //     '48da6134-b2ee-405b-ad74-3f520bb3043d');
          threads.add(thread);
        }
        return threads;
      },
    ).catchError(
      (err) {
        print("Status err code: $err");
      },
    );
  }

  Future<List<ThreadMessage>> getThreadMessages(
    String threadHash, {
    int page = 0,
  }) async {
    HeaderSecurity headerSecurity =
        await configurationService.getSecurityHeaderInstance();
    return _freightClient
        .get(
      "/threads/$threadHash/messages?zeroBasedPage=$page",
      FreightChatMapHelper.mapToThreadMessage,
      options: Options(
        headers: {
          "newgo-security": jsonEncode(HeaderSecurity.toJson(headerSecurity)),
        },
      ),
    )
        .then((listThreads) {
      return listThreads;
    }).catchError((err) {
      print("Status err code: $err");
    });
  }

  Future<DriverThreads> getAttendanceChannelThread() async {
    HeaderSecurity headerSecurity =
        await configurationService.getSecurityHeaderInstance();

    return _freightClient.get("/${headerSecurity.hash}/threads",
        FreightChatMapHelper.mapToDriverThreads,
        options: Options(headers: {
          "newgo-security": jsonEncode(HeaderSecurity.toJson(headerSecurity))
        }),
        queryParameters: {
          'referenceType': 'ATTENDANCE_CHANNEL',
        }).then((listThreads) async {
      return listThreads[0];
    }).catchError((err) {
      print("Status err code: $err");
    });
  }

  Future<ThreadMessage> sendThreadMessage(
    ThreadMessage message,
    String threadHash,
  ) async {
    HeaderSecurity headerSecurity =
        await configurationService.getSecurityHeaderInstance();

    var response = await _freightClient.post(
      "/threads/$threadHash/messages",
      FreightChatMapHelper.mapToReceiveResponseSendMessage,
      data: ThreadMessage.toJson(message),
      options: Options(
        headers: {
          "newgo-security": jsonEncode(HeaderSecurity.toJson(headerSecurity))
        },
      ),
    );
    return response;
  }

  Future<void> deleteThread(String threadHash) async {
    HeaderSecurity headerSecurity =
        await configurationService.getSecurityHeaderInstance();

    _freightClient.delete(
      "/threads/$threadHash/messages",
      options: Options(headers: {
        "newgo-security": jsonEncode(HeaderSecurity.toJson(headerSecurity))
      }),
    );
  }

  Future<void> deleteThreadMessage(
      String threadHash, String messageHash) async {
    HeaderSecurity headerSecurity =
        await configurationService.getSecurityHeaderInstance();
    _freightClient.delete(
      "/threads/$threadHash/messages/$messageHash",
      options: Options(headers: {
        "newgo-security": jsonEncode(HeaderSecurity.toJson(headerSecurity))
      }),
    );
  }

  Future<ThreadFreightSummary> getFreightDataFromAppCargo(
      String threadHash) async {
    HeaderSecurity headerSecurity =
        await configurationService.getSecurityHeaderInstance();

    return _freightClient
        .getFreightsFromAppCargo(
      "/v1/freights?hashes=$threadHash",
      FreightChatMapHelper.mapToAppCargoFreights,
      options: Options(headers: {
        "newgo-security": jsonEncode(HeaderSecurity.toJson(headerSecurity))
      }),
    )
        .then((listFreightSummary) {
      return listFreightSummary;
    }).catchError((err) {
      print("Status err code: $err");
    });
  }
}

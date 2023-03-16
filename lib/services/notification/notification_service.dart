import 'dart:convert';

import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/chat/chat_member.dart';
import 'package:app_cargo/domain/chat/chat_with_id.dart';
import 'package:app_cargo/routes.dart';
import 'package:app_cargo/screens/message_quantity_state.dart';
import 'package:app_cargo/services/chat/chat_service.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:app_cargo/services/navigation/navigation_service.dart';
import 'package:app_cargo/services/notification/helper/local_notification_helper.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class NotificationService {
  final ConfigurationService _configurationService =
      DIContainer().get<ConfigurationService>();
  final ChatService _chatService = DIContainer().get<ChatService>();
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final ChatService chatMessageService = DIContainer().get<ChatService>();
  final ConfigurationService configurationService =
      DIContainer().get<ConfigurationService>();

  // Local notification
  final notifications = FlutterLocalNotificationsPlugin();

  final NavigationService navigationService =
      DIContainer().get<NavigationService>();

  bool isConfigured = false;

  Map mapRoute = Map();

  NotificationService() {
    mapRoute[Routes.driverAndFreightChat] = 'chat';
  }

  /// Get the token for the current device.
  Future<String> getDeviceToken() async {
    // Get the token for this device.
    String fcmToken = await _fcm.getToken();
    return fcmToken;
  }

  bool isNotConfigured() {
    return !this.isConfigured;
  }

  void configureNotificationHandling(BuildContext context) {
    isConfigured = true;

    // Local notification
    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);

    // FCM notification
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        if (mapRoute[message['data']['context']] == 'chat') {
          chatMessageService
              .getMemberByHash(message['data']['hashSender'])
              .then((ChatMember sender) {
            MessageQuantityState messageQuantityState =
                Provider.of<MessageQuantityState>(context);
            messageQuantityState.quantity = 0;
            messageQuantityState.changeQuantity(0);

            _configurationService.driverHash.then((hash) {
              _chatService.getAllChatsByMemberHash(hash).then((chats) {
                for (ChatWithId chatWithId in chats) {
                  _chatService
                      .getChatReceivedMessagesQuantity(
                          chatWithId.documentId, hash)
                      .then((quantity) {
                    messageQuantityState.changeQuantity(
                        messageQuantityState.quantity + quantity);
                  });
                }
              });
            });

            configurationService.driverHash.then((hash) {
              if (null != AppScaffold.chatScreen) {
                if (AppScaffold.chatScreen.membersHash[0] == hash &&
                    AppScaffold.chatScreen.membersHash[1] ==
                        message['data']['hashSender']) {
                  return;
                }
              }

              Map payloadMap = Map();
              payloadMap["route"] = message['data']['context'];
              payloadMap["hashSender"] = message['data']['hashSender'];

              showDefaultNotification(notifications,
                  title: "Nova mensagem",
                  body: "Você recebeu uma nova mensagem de '${sender.name}'",
                  payload: jsonEncode(payloadMap));
            });
          });
        }
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        if (mapRoute[message['data']['context']] == 'chat') {
          chatMessageService
              .getMemberByHash(message['data']['hashSender'])
              .then((data) {
            ChatMember senderMember = data;
            Navigator.pushNamed(context, message['data']['context'],
                arguments: {"otherChatMember": senderMember});
          });
        }
      },
    );
  }

  Future onSelectNotification(String payload) {
    return Future<void>.value();
  }
}

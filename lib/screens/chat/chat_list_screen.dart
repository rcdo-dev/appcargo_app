import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/analytics_events_constants.dart';

import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/chat/chat.dart';
import 'package:app_cargo/domain/chat/chat_member.dart';
import 'package:app_cargo/domain/chat/chat_with_id.dart';
import 'package:app_cargo/services/chat/chat_service.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:app_cargo/widgets/app_confirm_popup.dart';
import 'package:app_cargo/widgets/app_loading_text.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/app_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import '../message_quantity_state.dart';

class ChatListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  ChatService _chatService = DIContainer().get<ChatService>();
  final ConfigurationService _configurationService =
      DIContainer().get<ConfigurationService>();

  FacebookAppEvents _facebookAppEvents = DIContainer().get<FacebookAppEvents>();
  FirebaseAnalytics _firebaseAnalytics = DIContainer().get<FirebaseAnalytics>();

  Stream _stream;
  String _currentHash;

  TextEditingController _searchTextEditingController;

  String searchName = "";

  @override
  void initState() {
    super.initState();
    _firebaseAnalytics.setCurrentScreen(screenName: Routes.chatList);
    _searchTextEditingController = TextEditingController();

    DIContainer().get<ConfigurationService>().driverHash.then((driverHash) {
      setState(() {
        _stream = DIContainer()
            .get<ChatService>()
            .getChatStreamByMemberHash(driverHash);
        _currentHash = driverHash;
      });
    });
  }

  Future<ChatMemberWithChatInfo> getOtherChatMemberWithChatInfo(
      Chat chat, String chatDocumentID, String driverHash) async {
    ChatMember chatMember = await DIContainer()
        .get<ChatService>()
        .getOtherMemberFor(_currentHash, chat);
    int messagesQuantity =
        await _chatService.getChatMessagesQuantity(chatDocumentID);
    int messagesReceived = await _chatService.getChatReceivedMessagesQuantity(
        chatDocumentID, driverHash);

    ChatQuantityInfo chatQuantityInfo = ChatQuantityInfo(
        chatMessagesQuantity: messagesQuantity,
        chatMessagesReceived: messagesReceived);

    return ChatMemberWithChatInfo(
        chatQuantityInfo: chatQuantityInfo, chatMember: chatMember);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        showAppBar: true,
        showMenu: false,
        scrollable: false,
        title: "Conversas",
        trailingActions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10),
            width: 50,
            child: IconButton(
              onPressed: () {
                showAppConfirmPopup(
                    context,
                    "Limpar conversas",
                    "Você tem certeza que deseja remover todas as conversas?",
                    "Sim, tenho",
                    () {
                      _configurationService.driverHash.then((hash) {
                        _chatService
                            .getAllChatsByMemberHash(hash)
                            .then((chats) async {
                          for (ChatWithId item in chats) {
                            String currentChatDocumentID = item.documentId;

                            await _chatService
                                .removeAllMessagesFrom(currentChatDocumentID);
                          }

                          setState(() {
                            MessageQuantityState messageQuantityState =
                                Provider.of<MessageQuantityState>(context);
                            messageQuantityState.quantity = 0;
                            messageQuantityState.changeQuantity(0);

                            _configurationService.driverHash.then((hash) {
                              _chatService
                                  .getAllChatsByMemberHash(hash)
                                  .then((chats) {
                                for (ChatWithId chatWithId in chats) {
                                  _chatService
                                      .getChatReceivedMessagesQuantity(
                                          chatWithId.documentId, hash)
                                      .then((quantity) {
                                    messageQuantityState.changeQuantity(
                                        messageQuantityState.quantity +
                                            quantity);
                                  });
                                }
                                Navigator.pop(context);
                              });
                            });
                          });
                        });
                      });
                    },
                    cancelOptionTitle: "Cancelar",
                    onCancel: () {
                      Navigator.pop(context);
                    });
              },
              icon: Icon(Icons.delete),
            ),
          ),
        ],
        body: Container(
          color: AppColors.light_grey,
          child: Column(
            children: <Widget>[
              Container(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: AppTextField(
                  hint: "Nome do contato...",
                  prefixIcon: Icon(Icons.search),
                  textEditingController: _searchTextEditingController,
                  onChanged: (String value) {
                    setState(() {
                      searchName = value;
                    });
                  },
                ),
              ),
              Flexible(
                child: StreamBuilder(
                  stream: _stream,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Container();
                      default:
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, idx) {
                            Chat chat;
                            chat = Chat.fromJson(
                                snapshot.data.documents[idx].data);
                            chat.lastSent =
                                Timestamp.fromMillisecondsSinceEpoch((snapshot
                                        .data
                                        .documents[idx]["lastSent"]
                                        .seconds *
                                    1000));

                            String dateInfo;
                            Future<ChatMemberWithChatInfo>
                                otherChatMemberWithChatInfo =
                                getOtherChatMemberWithChatInfo(
                                    chat,
                                    snapshot.data.documents[idx].documentID,
                                    _currentHash);

                            final now = DateTime.now();
                            final today =
                                DateTime(now.year, now.month, now.day);
                            final chatLastSentWithoutTime = DateTime(
                              snapshot.data.documents[idx]["lastSent"]
                                  .toDate()
                                  .year,
                              snapshot.data.documents[idx]["lastSent"]
                                  .toDate()
                                  .month,
                              snapshot.data.documents[idx]["lastSent"]
                                  .toDate()
                                  .day,
                            );

                            final isToday = today == chatLastSentWithoutTime;
                            if (isToday) {
                              dateInfo =
                                  "${snapshot.data.documents[idx]["lastSent"].toDate().hour.toString().padLeft(2, '0')}:"
                                  "${snapshot.data.documents[idx]["lastSent"].toDate().minute.toString().padLeft(2, '0')}";
                            } else {
                              if (today
                                      .difference(chatLastSentWithoutTime)
                                      .inDays ==
                                  1) {
                                dateInfo = "Ontem";
                              } else {
                                dateInfo =
                                    "${snapshot.data.documents[idx]["lastSent"].toDate().day.toString().padLeft(2, '0')}/"
                                    "${snapshot.data.documents[idx]["lastSent"].toDate().month.toString().padLeft(2, '0')}/"
                                    "${snapshot.data.documents[idx]["lastSent"].toDate().year.toString()}";
                              }
                            }

                            return FutureBuilder(
                              future: otherChatMemberWithChatInfo,
                              builder: (context, snap) {
                                switch (snap.connectionState) {
                                  case ConnectionState.none:
                                  case ConnectionState.active:
                                  case ConnectionState.waiting:
                                    return AppLoadingText();
                                  case ConnectionState.done:
                                    if (snap.hasData)
                                      return Container(
                                        child: snap.data.chatMember.name
                                                    .toString()
                                                    .toLowerCase()
                                                    .startsWith(searchName
                                                        .toLowerCase()) &&
                                                snap.data.chatQuantityInfo
                                                        .chatMessagesQuantity >
                                                    0
                                            ? Material(
                                                color: Colors.white70,
                                                child: InkWell(
                                                  onTap: () {
                                                    _facebookAppEvents.logEvent(
                                                        name: AnalyticsEventsConstants
                                                            .driverAndFreightChat,
                                                        parameters: {
                                                          AnalyticsEventsConstants
                                                                  .action:
                                                              AnalyticsEventsConstants
                                                                  .viewEntrance
                                                        });

                                                    _firebaseAnalytics.logEvent(
                                                        name: AnalyticsEventsConstants
                                                            .driverAndFreightChat,
                                                        parameters: {
                                                          AnalyticsEventsConstants
                                                                  .action:
                                                              AnalyticsEventsConstants
                                                                  .viewEntrance
                                                        });

                                                    Navigator.pushNamed(
                                                      context,
                                                      Routes
                                                          .driverAndFreightChat,
                                                      arguments: {
                                                        "otherChatMember": snap
                                                            .data.chatMember,
                                                      },
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 12,
                                                            horizontal: 12),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          child: snap.data.chatMember
                                                                          .imageUrl ==
                                                                      'http://cdn.onlinewebfonts.com/svg/img_329402.png' ||
                                                                  snap
                                                                          .data
                                                                          .chatMember
                                                                          .imageUrl ==
                                                                      null
                                                              ? Image.asset(
                                                                  "assets/images/ic_support_customer.png",
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  height: 50,
                                                                  width: 50)
                                                              : FadeInImage
                                                                  .assetNetwork(
                                                                  placeholder:
                                                                      "assets/images/loadingImage.gif",
                                                                  image: snap
                                                                      .data
                                                                      .chatMember
                                                                      .imageUrl,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  height: 60,
                                                                  width: 60,
                                                                ),
                                                        ),
                                                        SizedBox(width: 16),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: <Widget>[
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            5.0),
                                                                child: Text(
                                                                  snap
                                                                      .data
                                                                      .chatMember
                                                                      .name,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              // Text(
                                                              //   snap
                                                              //       .data
                                                              //       .chatMember
                                                              //       .phone,
                                                              //   style:
                                                              //       TextStyle(
                                                              //     fontSize: 16,
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                        ),
                                                        Column(
                                                          children: <Widget>[
                                                            Text(
                                                              snap
                                                                  .data
                                                                  .chatQuantityInfo
                                                                  .chatMessagesReceived
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: AppColors
                                                                      .green),
                                                            ),
                                                            Text(
                                                              dateInfo,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15),
                                                          child: IconButton(
                                                            icon: Icon(
                                                              Icons
                                                                  .delete_forever,
                                                              color: AppColors
                                                                  .green,
                                                            ),
                                                            onPressed: () {
                                                              showAppConfirmPopup(
                                                                  context,
                                                                  "Remover conversa",
                                                                  "Deseja mesmo remover toda a conversa com '${snap.data.chatMember.name}'?",
                                                                  "Sim, desejo",
                                                                  () async {
                                                                    setState(
                                                                        () {
                                                                      _chatService
                                                                          .removeAllMessagesFrom(snapshot
                                                                              .data
                                                                              .documents[idx]
                                                                              .documentID)
                                                                          .then((_) {
                                                                        MessageQuantityState
                                                                            messageQuantityState =
                                                                            Provider.of<MessageQuantityState>(context);
                                                                        messageQuantityState
                                                                            .quantity = 0;
                                                                        messageQuantityState
                                                                            .changeQuantity(0);

                                                                        _configurationService
                                                                            .driverHash
                                                                            .then((hash) {
                                                                          _chatService
                                                                              .getAllChatsByMemberHash(hash)
                                                                              .then((chats) {
                                                                            for (ChatWithId chatWithId
                                                                                in chats) {
                                                                              _chatService.getChatReceivedMessagesQuantity(chatWithId.documentId, hash).then((quantity) {
                                                                                messageQuantityState.changeQuantity(messageQuantityState.quantity + quantity);
                                                                              });
                                                                            }
                                                                            Navigator.pop(context);
                                                                          });
                                                                        });
                                                                      });
                                                                    });
                                                                  },
                                                                  cancelOptionTitle:
                                                                      "Cancelar",
                                                                  onCancel: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      );
                                }
                                return null;
                              },
                            );
                          },
                          separatorBuilder: (context, idx) {
                            return Divider(
                              height: 1,
                              color: AppColors.light_grey,
                            );
                          },
                        );
                        break;
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class ChatWithSender {
  ChatWithId chatWithId;
  ChatMember chatMember;

  ChatWithSender(this.chatWithId, this.chatMember);
}

class ChatQuantityInfo {
  int chatMessagesQuantity = 0;
  int chatMessagesReceived = 0;

  ChatQuantityInfo({this.chatMessagesQuantity, this.chatMessagesReceived});
}

class ChatMemberWithChatInfo {
  ChatQuantityInfo chatQuantityInfo;
  ChatMember chatMember;

  ChatMemberWithChatInfo({this.chatQuantityInfo, this.chatMember});
}

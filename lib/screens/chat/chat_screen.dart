import 'dart:async';
import 'dart:io';

import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/analytics_events_constants.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/chat/chat.dart';
import 'package:app_cargo/domain/chat/chat_with_id.dart';
import 'package:app_cargo/domain/chat/message/message.dart';
import 'package:app_cargo/domain/chat/report/report.dart';
import 'package:app_cargo/routes.dart';
import 'package:app_cargo/screens/chat/chat_info.dart';
import 'package:app_cargo/screens/chat/chat_firebase_auth_configuration.dart';
import 'package:app_cargo/screens/chat/constants/chat_file_configuration_constants.dart';
import 'package:app_cargo/screens/chat/constants/chat_messages_constants.dart';
import 'package:app_cargo/screens/chat/widgets/chat_message_card.dart';
import 'package:app_cargo/screens/message_quantity_state.dart';
import 'package:app_cargo/services/chat/chat_service.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:app_cargo/widgets/app_confirm_popup.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/app_text_field.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';
import 'package:holding_gesture/holding_gesture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ntp/ntp.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_confirm_popup.dart';
import '../../widgets/show_message_dialog.dart';

class ChatScreen extends StatefulWidget {
  List<String> membersHash;
  List<Map> _entities;
  bool isPremium;

  ChatScreen(List<String> _membersHash, List<Map> _entities, bool isPremium) {
    this.membersHash = _membersHash;
    this._entities = _entities;
    this.isPremium = isPremium;
  }

  @override
  State<StatefulWidget> createState() =>
      ChatScreenState(membersHash, _entities, isPremium);
}

class ChatScreenState extends State<ChatScreen> {
  final ConfigurationService _configurationService =
      DIContainer().get<ConfigurationService>();
  final ChatService _chatService = DIContainer().get<ChatService>();
  final ChatFirebaseAuthConfiguration chatFirebaseAuthConfiguration =
      ChatFirebaseAuthConfiguration();

  FacebookAppEvents _facebookAppEvents = DIContainer().get<FacebookAppEvents>();
  FirebaseAnalytics _firebaseAnalytics = DIContainer().get<FirebaseAnalytics>();

  final List<String> membersHash;
  final List<Map> _entities;
  final bool _isPremium;

  Chat _chat;
  String _chatDocumentID;
  Stream _stream;

  final _messageTextEditingController = TextEditingController();
  bool _isTyping = false;
  bool isRecordingAudio = false;
  bool isAudioRecorderInitialized = false;

  bool isReporting = false;

  Stopwatch chatAudioStopwatch = new Stopwatch();
  Timer chatAudioTimer;
  String chatAudioElapsedTime = '';
  FlutterAudioRecorder recorder;

  bool hasAudioPermission = false;

  final String chatMenuInfo = "info";
  final String chatMenuClear = "clear";

  ChatScreenState(this.membersHash, this._entities, this._isPremium);

  @override
  void initState() {
    super.initState();

    _facebookAppEvents.logEvent(
        name: AnalyticsEventsConstants.chatView,
        parameters: {
          AnalyticsEventsConstants.action: AnalyticsEventsConstants.viewEntrance
        });

    _firebaseAnalytics.logEvent(
      name: AnalyticsEventsConstants.chatView,
      parameters: {
        AnalyticsEventsConstants.action: AnalyticsEventsConstants.viewEntrance
      },
    );

    _handleAudioPermission();
    chatFirebaseAuthConfiguration.handleFirebaseAuth().then((_) {
      _getChatMap(membersHash);
      print("HASH 1 = ${membersHash[0]} | HASH 2 = ${membersHash[1]}");
    });
  }

  void _handleAudioPermission() async {
    FlutterAudioRecorder.hasPermissions.then((hasPermissions) {
      hasAudioPermission = hasPermissions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_entities[1]["name"]),
        backgroundColor: AppColors.green,
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == "info") {
                if (_chat != null) {
                  _chatService
                      .getChatMessagesQuantity(_chatDocumentID)
                      .then((quantity) {
                    _chatService
                        .getChatLastSent(_chatDocumentID)
                        .then((lastSent) {
                      Navigator.pushNamed(context, Routes.chatInfo, arguments: {
                        "chatInfo": ChatInfo(
                            chatDocumentID: _chatDocumentID,
                            membersName: [
                              _entities[0]["name"],
                              _entities[1]["name"]
                            ],
                            lastSent: lastSent,
                            messagesQuantity: quantity),
                      });
                    });
                  });
                } else {
                  showMessageDialog(context,
                      type: DialogType.ERROR,
                      message:
                          "Você ainda não possui um chat com esse contato");
                }
              } else if (value == chatMenuClear) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          "Limpar conversa",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text(
                          "Deseja mesmo limpar esta conversa?",
                          style: TextStyle(fontSize: 17),
                        ),
                        actions: <Widget>[
                          SkyButton(
                            text: "Cancelar",
                            borderRadius: 5,
                            textColor: AppColors.black,
                            fontSize: 15,
                            buttonColor: AppColors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          SkyButton(
                            text: "Limpar conversa",
                            borderRadius: 5,
                            textColor: AppColors.white,
                            fontSize: 15,
                            buttonColor: AppColors.green,
                            onPressed: () {
                              _chatService
                                  .removeAllMessagesFrom(_chatDocumentID);
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
                            },
                          )
                        ],
                      );
                    });
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Informações da conversa"),
                value: "info",
              ),
              PopupMenuItem(
                child: Text("Limpar conversa"),
                value: "clear",
              ),
            ],
          )
        ],
      ),
      body: Container(
        color: AppColors.light_grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Panel
            Expanded(
              child: StreamBuilder(
                stream: _stream,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Container();
                    default:
                      return ListView.builder(
                          padding: EdgeInsets.all(8.0),
                          itemCount: snapshot.data.documents.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            Map messageMap =
                                snapshot.data.documents[index].data;

                            Message message = Message();
                            message.documentID =
                                snapshot.data.documents[index].documentID;
                            message.timestamp =
                                messageMap[ChatService.timestampAttribute];
                            message.hashSender =
                                messageMap[ChatService.hashSenderAttribute];
                            message.content =
                                messageMap[ChatService.contentAttribute];
                            message.showToDriver =
                                messageMap[ChatService.showToDriverAttribute];
                            message.showToPartnerOrFreightCo = messageMap[
                                ChatService.showToPartnerOrFreightCoAttribute];
                            bool isMe =
                                messageMap[ChatService.hashSenderAttribute] ==
                                    membersHash[0];

                            if (message.showToDriver == null)
                              message.showToDriver = true;

                            return message.showToDriver
                                ? ChatMessageCard(
                                    message,
                                    isMe,
                                    onLeftSwipe: (Message message) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              "Remover mensagem",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            content: Text(
                                              "Deseja mesmo remover esta mensagem?",
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            actions: <Widget>[
                                              SkyButton(
                                                text: "Cancelar",
                                                borderRadius: 5,
                                                textColor: AppColors.black,
                                                fontSize: 15,
                                                buttonColor: AppColors.white,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              SkyButton(
                                                text: "Apagar para mim",
                                                borderRadius: 5,
                                                textColor: AppColors.white,
                                                fontSize: 15,
                                                buttonColor: AppColors.green,
                                                onPressed: () {
                                                  _chatService.removeMessage(
                                                      _chatDocumentID, message);
                                                  MessageQuantityState
                                                      messageQuantityState =
                                                      Provider.of<
                                                              MessageQuantityState>(
                                                          context);
                                                  messageQuantityState
                                                      .quantity = 0;
                                                  messageQuantityState
                                                      .changeQuantity(0);

                                                  _configurationService
                                                      .driverHash
                                                      .then((hash) {
                                                    _chatService
                                                        .getAllChatsByMemberHash(
                                                            hash)
                                                        .then((chats) {
                                                      for (ChatWithId chatWithId
                                                          in chats) {
                                                        _chatService
                                                            .getChatReceivedMessagesQuantity(
                                                                chatWithId
                                                                    .documentId,
                                                                hash)
                                                            .then((quantity) {
                                                          messageQuantityState
                                                              .changeQuantity(
                                                                  messageQuantityState
                                                                          .quantity +
                                                                      quantity);
                                                        });
                                                      }
                                                      Navigator.pop(context);
                                                    });
                                                  });
                                                },
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    onRightSwipe: (Message message) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              "Denunciar mensagem",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            content: Text(
                                              "Deseja mesmo denunciar esta mensagem?",
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            actions: <Widget>[
                                              SkyButton(
                                                text: "Cancelar",
                                                borderRadius: 5,
                                                textColor: AppColors.black,
                                                fontSize: 15,
                                                buttonColor: AppColors.white,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              SkyButton(
                                                text: "Denunciar",
                                                borderRadius: 5,
                                                textColor: AppColors.white,
                                                fontSize: 15,
                                                buttonColor: AppColors.green,
                                                onPressed: () {
                                                  if (!isReporting) {
                                                    isReporting = true;
                                                    NTP.now().then((now) {
                                                      Report report = Report();
                                                      report.message = message;
                                                      report.timestamp =
                                                          Timestamp.fromDate(
                                                              now);
                                                      report.receiverHash =
                                                          membersHash[0];
                                                      report.receiverName =
                                                          _entities[0]["name"];
                                                      report.receiverPhone =
                                                          _entities[0]["phone"];
                                                      report.senderHash =
                                                          membersHash[1];
                                                      report.senderName =
                                                          _entities[1]["name"];
                                                      report.senderPhone =
                                                          _entities[1]["phone"];

                                                      _chatService
                                                          .saveReport(report)
                                                          .then((hash) {
                                                        Navigator.pop(context);
                                                        isReporting = false;
                                                      });
                                                    });
                                                  }
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  )
                                : Container();
                          });
                  }
                },
              ),
            ),
            // Dock
            Container(
              color: AppColors.white,
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                  !isRecordingAudio
                      ? Container()
                      : Expanded(
                          child: Row(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    chatAudioElapsedTime,
                                    style: TextStyle(fontSize: 25),
                                  )),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text("Gravando...",
                                    style: TextStyle(
                                        fontSize: 15, color: AppColors.green)),
                              )
                            ],
                          ),
                        ),
                  if (this._isPremium)
                    !isRecordingAudio ? _buildSendVideoButton() : Container(),
                  if (this._isPremium)
                    !isRecordingAudio ? _buildSendImageButton() : Container(),
                  if (this._isPremium)
                    !isRecordingAudio ? _buildMessageTextField() : Container(),
                  if (this._isPremium)
                    _isTyping
                        ? _buildSendTextMessageButton()
                        : _buildSendAudioButton(context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _handlePickImage(
      BuildContext context, ImageSource imageSource, int imageQuality) {
    ImagePicker.pickImage(source: imageSource, imageQuality: imageQuality).then(
      (File image) {
        setState(
          () {
            if (image != null) {
              try {
                image.length().then((data) {
                  if (data <=
                      ChatFileConfigurationConstants
                          .imageAndVideoLimitInBytes) {
                    _facebookAppEvents.logEvent(
                        name: AnalyticsEventsConstants.messageImagesSend,
                        parameters: {
                          AnalyticsEventsConstants.action:
                              AnalyticsEventsConstants.imageFile,
                          AnalyticsEventsConstants.bytesLength:
                              "${(data.bitLength / 8).toString()}"
                        });

                    _firebaseAnalytics.logEvent(
                        name: AnalyticsEventsConstants.messageImagesSend,
                        parameters: {
                          AnalyticsEventsConstants.action:
                              AnalyticsEventsConstants.imageFile,
                          AnalyticsEventsConstants.bytesLength:
                              "${(data.bitLength / 8).toString()}"
                        });

                    _handleSendImageMessage(image);
                  } else {
                    showMessageDialog(context,
                        message: ChatMessagesConstants.fileLimitErrorMessage);
                  }
                });
              } catch (e) {
                showMessageDialog(context, message: "Erro ao enviar a imagem");
              }
            }
          },
        );
      },
    );
  }

  void _handlePickVideo(BuildContext context, ImageSource imageSource) {
    ImagePicker.pickVideo(source: imageSource).then(
      (File video) {
        setState(
          () {
            if (video != null) {
              try {
                video.length().then((data) {
                  if (data <=
                      ChatFileConfigurationConstants
                          .imageAndVideoLimitInBytes) {
                    _facebookAppEvents.logEvent(
                        name: AnalyticsEventsConstants.messageVideoSend,
                        parameters: {
                          AnalyticsEventsConstants.action:
                              AnalyticsEventsConstants.videoFile,
                          AnalyticsEventsConstants.bytesLength:
                              "${(data.bitLength / 8).toString()}"
                        });

                    _firebaseAnalytics.logEvent(
                        name: AnalyticsEventsConstants.messageVideoSend,
                        parameters: {
                          AnalyticsEventsConstants.action:
                              AnalyticsEventsConstants.videoFile,
                          AnalyticsEventsConstants.bytesLength:
                              "${(data.bitLength / 8).toString()}"
                        });

                    _handleSendVideoMessage(video);
                  } else {
                    showMessageDialog(context,
                        message: ChatMessagesConstants.fileLimitErrorMessage);
                  }
                });
              } catch (e) {
                showMessageDialog(context, message: "Erro ao enviar o vídeo");
              }
            }
          },
        );
      },
    );
  }

  Widget _buildMessageTextField() {
    return Expanded(
      child: AppTextField(
        onChanged: (value) {
          setState(() {
            _isTyping = value.isNotEmpty;
          });
        },
        borderRadius: 20,
        hint: "Digite uma mensagem...",
        textEditingController: _messageTextEditingController,
        verticalContentPadding: 8.0,
      ),
    );
  }

  Widget _buildSendVideoButton() {
    return IconButton(
      onPressed: () {
        showAppConfirmPopup(
          context,
          "De onde deseja pegar o vídeo?",
          "Escolha uma opção.",
          "Da câmera",
          () {
            Navigator.pop(context);
            _handlePickVideo(context, ImageSource.camera);
          },
          cancelOptionTitle: "Da galeria",
          onCancel: () {
            Navigator.pop(context);
            _handlePickVideo(context, ImageSource.gallery);
          },
        );
      },
      icon: Icon(
        Icons.videocam,
        color: AppColors.blue,
      ),
    );
  }

  Widget _buildSendImageButton() {
    return IconButton(
      onPressed: () {
        showAppConfirmPopup(
          context,
          "De onde deseja pegar a imagem?",
          "Escolha uma opção.",
          "Da câmera",
          () {
            Navigator.pop(context);
            _handlePickImage(context, ImageSource.camera, 70);
          },
          cancelOptionTitle: "Da galeria",
          onCancel: () {
            Navigator.pop(context);
            _handlePickImage(context, ImageSource.gallery, 70);
          },
        );
      },
      icon: Icon(
        Icons.photo_camera,
        color: AppColors.blue,
      ),
    );
  }

  Widget _buildSendAudioButton(BuildContext context) {
    return HoldDetector(
        onHold: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }

          if (!isRecordingAudio) {
            if (hasAudioPermission) {
              if (isAudioRecorderInitialized) {
                recorder.stop();
              }
              initAudioRecorder().then((_) async {
                recorder.start().then((_) {
                  startWatch();
                  recorder.current().then((data) {
                    print(data.path);
                    isAudioRecorderInitialized = true;
                  });
                });
              });
              setState(() {
                isRecordingAudio = true;
              });
            } else {
              showMessageDialog(context,
                  message: "Você precisa permitir ao AppCargo gravar áudio",
                  type: DialogType.ERROR);
            }
          }
        },
        onCancel: () {
          setState(() {
            if (hasAudioPermission) {
              int elapsed = chatAudioStopwatch.elapsedMilliseconds;
              resetWatch();
              stopWatch();
              isRecordingAudio = false;
              if (elapsed >= 1000) {
                showAppConfirmPopup(
                    context,
                    "Enviar mensagem de áudio",
                    "Deseja mesmo enviar este áudio?",
                    "Enviar",
                    () {
                      Navigator.pop(context);
                      recorder.stop().then((data) {
                        recorder.current().then((data) {
                          File audioFile = File(data.path);
                          audioFile.length().then((data) {
                            print("bytes: $data");
                            if (data <=
                                ChatFileConfigurationConstants
                                    .audioLimitInBytes) {
                              _facebookAppEvents.logEvent(
                                  name:
                                      AnalyticsEventsConstants.messageAudioSend,
                                  parameters: {
                                    AnalyticsEventsConstants.action:
                                        AnalyticsEventsConstants.audioFile,
                                    AnalyticsEventsConstants.bytesLength:
                                        "${(data.bitLength / 8).toString()}"
                                  });
                              _firebaseAnalytics.logEvent(
                                  name:
                                      AnalyticsEventsConstants.messageAudioSend,
                                  parameters: {
                                    AnalyticsEventsConstants.action:
                                        AnalyticsEventsConstants.audioFile,
                                    AnalyticsEventsConstants.bytesLength:
                                        "${(data.bitLength / 8).toString()}"
                                  });

                              _handleSendAudioMessage(audioFile);
                            } else {
                              showMessageDialog(context,
                                  message: ChatMessagesConstants
                                      .fileLimitErrorMessage);
                            }
                          });
                        });
                      });
                    },
                    cancelOptionTitle: "Cancelar",
                    onCancel: () {
                      Navigator.pop(context);
                      recorder.stop();
                    });
              } else {
                isRecordingAudio = false;
                resetWatch();
                stopWatch();
              }
            }
          });
        },
        child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: isRecordingAudio ? 0 : 10),
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(isRecordingAudio ? 15 : 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.yellow,
                ),
                child: SizedBox(
                  child: Icon(
                    Icons.mic,
                    size: isRecordingAudio ? 30 : 25,
                    color: AppColors.white,
                  ),
                ),
              ),
            )));
  }

  Widget _buildSendTextMessageButton() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: InkWell(
          onTap: () {
            if (_messageTextEditingController.text.isNotEmpty &&
                _messageTextEditingController.text
                    .replaceAll(" ", "")
                    .isNotEmpty) {
              _facebookAppEvents.logEvent(
                  name: AnalyticsEventsConstants.messageTextSend,
                  parameters: {
                    AnalyticsEventsConstants.action:
                        AnalyticsEventsConstants.textFile
                  });

              _firebaseAnalytics.logEvent(
                  name: AnalyticsEventsConstants.messageTextSend,
                  parameters: {
                    AnalyticsEventsConstants.action:
                        AnalyticsEventsConstants.textFile
                  });
              _handleSendTextMessage(_messageTextEditingController.text);
            }
          },
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.green,
            ),
            child: SizedBox(
              child: Icon(
                Icons.send,
                size: 21,
                color: AppColors.white,
              ),
            ),
          ),
        ));
  }

  void _handleSaveMessage(Message message) {
    if (_chat == null) {
      _chat = Chat(
          hidden: false, members: membersHash, lastSent: message.timestamp);

      _saveEntities().then((value) {
        _chatService.saveChat(_chat).then((data) {
          setState(() {
            _chatDocumentID = data;
            _chatService.saveMessage(_chat, message, _chatDocumentID);
            _stream = _chatService
                .getAllMessagesSnapshotsByChatDocumentID(_chatDocumentID);
            print(
                "created new chat: chat(hash:$_chatDocumentID, members: ${_chat.members}");
          });
        });
      });
    } else {
      setState(() {
        _chat.hidden = false;
        _chatService.saveMessage(_chat, message, _chatDocumentID);
      });
    }
  }

  void _handleSendTextMessage(String text) async {
    NTP.now().then((now) {
      Message message = Message(
          timestamp: Timestamp.fromDate(now),
          hashSender: membersHash[0],
          content: {"text": _messageTextEditingController.text},
          showToDriver: true,
          showToPartnerOrFreightCo: true);

      _handleSaveMessage(message);

      setState(() {
        _messageTextEditingController.text = "";
        _isTyping = false;
      });
    });
  }

  void _handleSendAudioMessage(File audio) {
    NTP.now().then((now) async {
      StorageReference reference = await FirebaseStorage.instance
          // .getReferenceFromUrl("gs://appcargo-brotherstec-chat");
          .getReferenceFromUrl("gs://appcargo-temporario.appspot.com");
      reference = reference
          .child("messages")
          .child(_chatDocumentID)
          .child("audios")
          .child(now.toString());

      StorageUploadTask uploadTask = reference.putFile(audio);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();

      Message message = Message(
          timestamp: Timestamp.fromDate(now),
          hashSender: membersHash[0],
          content: {"audio": url},
          showToDriver: true,
          showToPartnerOrFreightCo: true);

      _handleSaveMessage(message);
    });
  }

  void _handleSendImageMessage(File image) async {
    NTP.now().then((now) async {
      StorageReference reference = await FirebaseStorage.instance
          // .getReferenceFromUrl("gs://appcargo-brotherstec-chat");
          .getReferenceFromUrl("gs://appcargo-temporario.appspot.com");
      reference = reference
          .child("messages")
          .child(_chatDocumentID)
          .child("images")
          .child(now.toString());

      StorageUploadTask uploadTask = reference.putFile(image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();

      Message message = Message(
          timestamp: Timestamp.fromDate(now),
          hashSender: membersHash[0],
          content: {"image": url},
          showToDriver: true,
          showToPartnerOrFreightCo: true);

      _handleSaveMessage(message);
    });
  }

  void _handleSendVideoMessage(File video) async {
    NTP.now().then((now) async {
      StorageReference reference = await FirebaseStorage.instance
          // .getReferenceFromUrl("gs://appcargo-brotherstec-chat");
          .getReferenceFromUrl("gs://appcargo-temporario.appspot.com");

      reference = reference
          .child("messages")
          .child(_chatDocumentID)
          .child("videos")
          .child(now.toString());

      StorageUploadTask uploadTask = reference.putFile(video);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();

      Message message = Message(
          timestamp: Timestamp.fromDate(now),
          hashSender: membersHash[0],
          content: {"video": url},
          showToDriver: true,
          showToPartnerOrFreightCo: true);

      _handleSaveMessage(message);
    });
  }

  Future<void> _saveEntities() async {
    for (int i = 0; i < _entities.length; i++) {
      Map<String, dynamic> entity = Map<String, dynamic>.from(_entities[i]);
      _chatService.saveEntity(entity, membersHash[i]);
    }
  }

  void _getChatMap(List<String> members) async {
    Map chatMap = await _chatService.getChatByMembersHash(members);
    if (chatMap != null) {
      setState(() {
        _chat = chatMap["chat"];
        _chatDocumentID = chatMap["chatDocumentID"];
        _stream = _chatService
            .getAllMessagesSnapshotsByChatDocumentID(_chatDocumentID);
        _saveEntities();
        print("chat(hash: $_chatDocumentID, members: ${_chat.members})");
      });
    } else {
      print("there is no chat with these members");
    }
  }

  String transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr";
  }

  void startWatch() {
    chatAudioStopwatch.start();
    chatAudioTimer = Timer.periodic(Duration(milliseconds: 100), updateTime);
  }

  void resetWatch() {
    chatAudioStopwatch.reset();
    setTime();
  }

  void stopWatch() {
    chatAudioStopwatch.stop();
    setTime();
  }

  void setTime() {
    var timeSoFar = chatAudioStopwatch.elapsedMilliseconds;
    setState(() {
      chatAudioElapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  void updateTime(Timer timer) {
    if (chatAudioStopwatch.isRunning) {
      setState(() {
        chatAudioElapsedTime =
            transformMilliSeconds(chatAudioStopwatch.elapsedMilliseconds);
      });
    }
  }

  Future<dynamic> initAudioRecorder() async {
    String customPath = "/appcargo-audio_";
    Directory appDocDirectory;
    appDocDirectory = await getExternalStorageDirectory();

    customPath = appDocDirectory.path +
        customPath +
        DateTime.now().millisecondsSinceEpoch.toString();

    recorder = FlutterAudioRecorder(customPath);
    await recorder.initialized;
  }

  @override
  void dispose() {
    super.dispose();

    AppScaffold.chatScreen = null;
  }
}

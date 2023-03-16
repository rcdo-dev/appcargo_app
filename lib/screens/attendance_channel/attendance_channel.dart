import 'dart:async';
import 'dart:io';

import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/new_freight/message/thread_message.dart';
import 'package:app_cargo/screens/chat/constants/chat_file_configuration_constants.dart';
import 'package:app_cargo/screens/chat/constants/chat_messages_constants.dart';
import 'package:app_cargo/screens/freight_chat/state/chat_state.dart';
import 'package:app_cargo/screens/freight_chat/widgets/app_thread_message.dart';
import 'package:app_cargo/services/freight_chat/freight_chat_service.dart';
import 'package:app_cargo/widgets/app_confirm_popup.dart';
import 'package:app_cargo/widgets/app_text_field.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';
import 'package:holding_gesture/holding_gesture.dart';
import 'package:ntp/ntp.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class AttendanceChannel extends StatefulWidget {
  @override
  _AttendanceChannelState createState() => _AttendanceChannelState();
}

class _AttendanceChannelState extends State<AttendanceChannel> {
  final FreightChatService _freightChatService = DIContainer().get<FreightChatService>();

  final _messageTextEditingController = TextEditingController();
  bool isRecordingAudio = false;
  bool isAudioRecorderInitialized = false;

  Stopwatch chatAudioStopwatch = new Stopwatch();
  Timer chatAudioTimer;
  String chatAudioElapsedTime = '';
  FlutterAudioRecorder recorder;

  bool hasAudioPermission = false;

  String _attendanceChannelHash;

  int pagination = 1;
  List<ThreadMessage> _messageList = List<ThreadMessage>();
  bool isLoad = true;

  void timerProgressIndicator() {
    Timer.periodic(Duration(seconds: 3), (time) {
      setState(() {
        isLoad = false;
      });
      time.cancel();
    });
  }

  @override
  void initState() {
    super.initState();
    FlutterAudioRecorder.hasPermissions.then((hasPermissions) {
      hasAudioPermission = hasPermissions;
    });
    _messageList.add(null);
    fillMessages();
    timerProgressIndicator();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fale com a tatá"),
        backgroundColor: AppColors.green,
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              print("Opções");
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
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotify) {
                  if (scrollNotify is ScrollStartNotification) {
                    _onStartScroll(scrollNotify.metrics);
                  } else if (scrollNotify is ScrollUpdateNotification) {
                    _onUpdateScroll(scrollNotify.metrics);
                  } else if (scrollNotify is ScrollEndNotification) {
                    _onEndScroll(scrollNotify.metrics);
                  }
                  return true;
                },
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: _messageList.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    ThreadMessage message = new ThreadMessage();
                    message = _messageList[index];

                    if (_messageList[index] == null) {
                      if (isLoad) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: AppColors.light_green,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.green,
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text("Nenhuma mensagem encontrada..."),
                        );
                      }
                    }

                    return Container(
                      child: AppThreadMessage(
                        message,
                        _attendanceChannelHash,
                        onLeftSwipe: (ThreadMessage message) {
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
                                      _freightChatService.deleteThreadMessage(_attendanceChannelHash, _messageList[index].hash);
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        },
                        onRightSwipe: (ThreadMessage message) {
                          showMessageDialog(context, type: DialogType.INFO, message: "Não disponível ainda");
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            // Dock
            Consumer<ChatState>(
              builder: (context, provider, child) {
                return Container(
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
                                    child: Text("Gravando...", style: TextStyle(fontSize: 15, color: AppColors.green)),
                                  )
                                ],
                              ),
                            ),
                      !isRecordingAudio ? _buildSendVideoButton() : Container(),
                      !isRecordingAudio ? _buildSendImageButton() : Container(),
                      !isRecordingAudio
                          ? Consumer<ChatState>(
                              builder: (context, provider, child) {
                                return _buildMessageTextField(provider);
                              },
                            )
                          : Container(),
                      provider.isTyping ? _buildSendTextMessageButton(provider) : _buildSendAudioButton(context)
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void fillMessages() async {
    while (true) {
      setState(() {
        _freightChatService.getAttendanceChannelThread().then((thread) {
          _attendanceChannelHash = thread.hash;
          _freightChatService.getThreadMessages(thread.hash).then((response) {
            if (_messageList.first == null) {
              _messageList.removeLast();
            }
            if (response.isEmpty) {
              _messageList.add(null);
            } else {
              if (_messageList.isEmpty) {
                for (ThreadMessage msg in response.where((msg) => _messageList.firstWhere((element) => element.hash == msg.hash, orElse: () => null) == null)) {
                  _messageList.add(msg);
                }
              } else {
                for (ThreadMessage msg in response.where((msg) => _messageList.firstWhere((element) => element.hash == msg.hash, orElse: () => null) == null)) {
                  _messageList.insert(0, msg);
                }
              }
            }
          });
        });
      });
      await Future.delayed(Duration(seconds: 5));
    }
  }

  _onStartScroll(ScrollMetrics metrics) {
    print("Scroll Start: ${metrics}");
  }

  _onUpdateScroll(ScrollMetrics metrics) {
    if (metrics.maxScrollExtent == metrics.pixels) {
      //  pagination
      _freightChatService.getThreadMessages(_attendanceChannelHash, page: pagination).then((response) => {
            pagination++,
            for (ThreadMessage msg in response) {_messageList.add(msg)}
          });
    }
  }

  _onEndScroll(ScrollMetrics metrics) {
    print("Scroll End");
  }

  Widget _buildMessageTextField(ChatState provider) {
    return Expanded(
      child: AppTextField(
        onChanged: (value) {
          provider.checkUserIsTyping(value.isNotEmpty);
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
        // showAppConfirmPopup(
        //   context,
        //   "De onde deseja pegar o vídeo?",
        //   "Escolha uma opção.",
        //   "Da câmera",
        //   () {
        //     Navigator.pop(context);
        //     // _handlePickVideo(context, ImageSource.camera);
        //   },
        //   cancelOptionTitle: "Da galeria",
        //   onCancel: () {
        //     Navigator.pop(context);
        //     // _handlePickVideo(context, ImageSource.gallery);
        //   },
        // );

        setState(() {});
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
        // showAppConfirmPopup(
        //   context,
        //   "De onde deseja pegar a imagem?",
        //   "Escolha uma opção.",
        //   "Da câmera",
        //   () {
        //     Navigator.pop(context);
        //     // _handlePickImage(context, ImageSource.camera, 70);
        //   },
        //   cancelOptionTitle: "Da galeria",
        //   onCancel: () {
        //     Navigator.pop(context);
        //     // _handlePickImage(context, ImageSource.gallery, 70);
        //   },
        // );
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
              showMessageDialog(context, message: "Você precisa permitir ao AppCargo gravar áudio", type: DialogType.ERROR);
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
                            if (data <= ChatFileConfigurationConstants.audioLimitInBytes) {
                              _handleSendAudioMessage(audioFile);
                            } else {
                              showMessageDialog(context, message: ChatMessagesConstants.fileLimitErrorMessage);
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
            padding: EdgeInsets.symmetric(horizontal: isRecordingAudio ? 0 : 10),
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

  Widget _buildSendTextMessageButton(ChatState provider) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: InkWell(
          onTap: () {
            if (_messageTextEditingController.text.isNotEmpty && _messageTextEditingController.text.replaceAll(" ", "").isNotEmpty) {
              _handleSendTextMessage(_messageTextEditingController.text, provider);
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

  void _handleSendTextMessage(String text, ChatState provider) async {
    ThreadMessage message = ThreadMessage(content: text, sentByDriver: true, media: null, mediaContentType: null, sentAt: NTP.now().toString());

    _handleSaveMessage(message, provider);

    setState(() {
      _messageTextEditingController.text = "";
    });
  }

  void _handleSaveMessage(ThreadMessage message, ChatState provider) {
    _freightChatService.sendThreadMessage(message, _attendanceChannelHash).then((message) {
      provider.isTyping = false;
    });
  }

  void _handleSendAudioMessage(File audio) {}

  void _handleSendImageMessage(File image) async {}

  void _handleSendVideoMessage(File video) async {}

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
        chatAudioElapsedTime = transformMilliSeconds(chatAudioStopwatch.elapsedMilliseconds);
      });
    }
  }

  Future<dynamic> initAudioRecorder() async {
    String customPath = "/appcargo-audio_";
    Directory appDocDirectory;
    appDocDirectory = await getExternalStorageDirectory();

    customPath = appDocDirectory.path + customPath + DateTime.now().millisecondsSinceEpoch.toString();

    recorder = FlutterAudioRecorder(customPath);
    await recorder.initialized;
  }
}

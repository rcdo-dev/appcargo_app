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
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';
import 'package:holding_gesture/holding_gesture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ntp/ntp.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class ThreadsDetails extends StatefulWidget {
  @override
  _ThreadsDetailsState createState() => _ThreadsDetailsState();
}

class _ThreadsDetailsState extends State<ThreadsDetails> {
  final FreightChatService _freightChatService =
      DIContainer().get<FreightChatService>();

  final _messageTextEditingController = TextEditingController();
  bool isRecordingAudio = false;
  bool isAudioRecorderInitialized = false;

  Stopwatch chatAudioStopwatch = new Stopwatch();
  Timer chatAudioTimer;
  String chatAudioElapsedTime = '';
  FlutterAudioRecorder recorder;

  bool hasAudioPermission = false;

  int _fileSize = 0;
  bool fileLoaded;

  String _threadHash;

  int pagination = 1;
  List<ThreadMessage> _messageList = List<ThreadMessage>();

  Stream<List<ThreadMessage>> stream;

  @override
  void initState() {
    super.initState();

    FlutterAudioRecorder.hasPermissions.then((hasPermissions) {
      hasAudioPermission = hasPermissions;
    });
    stream = fillChat();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    if (null != args && args.isNotEmpty) {
      _threadHash = args["thread_hash"] as String;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Mensagens do frete"),
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
        color: AppColors.grey.withOpacity(0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Panel
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotify) {
                  if (scrollNotify is ScrollUpdateNotification) {
                    _onUpdateScroll(scrollNotify.metrics);
                  }
                  return true;
                },
                child: StreamBuilder<List<ThreadMessage>>(
                  stream: stream,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: AppColors.light_green,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.green,
                            ),
                          ),
                        );
                        break;
                      case ConnectionState.active:
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Erro ao carregar as mensagens. Tente novamente!',
                            ),
                          );
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            padding: EdgeInsets.all(8.0),
                            itemCount: snapshot.data.length,
                            reverse: true,
                            itemBuilder: (context, index) {
                              ThreadMessage message = new ThreadMessage();
                              message = snapshot.data[index];

                              return Container(
                                child: AppThreadMessage(
                                  message,
                                  _threadHash,
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
                                                _freightChatService
                                                    .deleteThreadMessage(
                                                  _threadHash,
                                                  _messageList[index].hash,
                                                );
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  onRightSwipe: (ThreadMessage message) {
                                    showMessageDialog(
                                      context,
                                      type: DialogType.INFO,
                                      message: "Não disponível ainda",
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        } else {
                          Center(
                            child: Text(
                              "Lista de mensagens vazia",
                            ),
                          );
                        }
                        break;
                      default:
                        Center(
                          child: Text(
                            "Nenhuma mensagem encontrada",
                          ),
                        );
                    }
                    return Text('State: ${snapshot.connectionState}');
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      chatAudioElapsedTime,
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "Gravando...",
                                      style: TextStyle(
                                          fontSize: 15, color: AppColors.green),
                                    ),
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
                      provider.isTyping
                          ? _buildSendTextMessageButton(provider)
                          : _buildSendAudioButton(context)
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

  void fillChatByPressingSendButton() {
    try {
      _freightChatService.getThreadMessages(_threadHash).then((value) {
        _messageList = value;
        setState(() {});
      });
    } catch (e) {
      throw Exception('Exceção ao carregar as mensagens: $e');
    }
  }

  Stream<List<ThreadMessage>> fillChat() async* {
    while (true) {
      _messageList = await _freightChatService.getThreadMessages(_threadHash);
      yield _messageList;
      await Future.delayed(Duration(seconds: 5));
    }
  }

  _onUpdateScroll(ScrollMetrics metrics) {
    if (metrics.maxScrollExtent == metrics.pixels) {
      _freightChatService
          .getThreadMessages(_threadHash, page: pagination)
          .then((response) => {
                pagination++,
                for (ThreadMessage msg in response) {_messageList.add(msg)}
              });
    }
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
        showAppConfirmPopup(
          context,
          "De onde deseja pegar o vídeo?",
          "Escolha uma opção.",
          "Da câmera",
          () {
            generateVideo(flag: true);
            Navigator.pop(context);
          },
          cancelOptionTitle: "Da galeria",
          onCancel: () {
            generateVideo(flag: false);
            Navigator.pop(context);
          },
        );
      },
      icon: Icon(
        Icons.videocam,
        color: AppColors.blue,
      ),
    );
  }

  File imageCamera;
  File imageGallery;

  final _picker = ImagePicker();

  Future<void> generateVideo({@required bool flag}) async {
    if (flag) {
      PickedFile pickedFile = await _picker.getVideo(
        source: ImageSource.camera,
      );
      File video = File(pickedFile.path);
      fileLoaded = await _handleSaveFileMessage(video);
    } else {
      FilePickerResult fileType = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );

      PlatformFile file = fileType.files.first;
      _fileSize = file.size;
      print('Tamanho do arquivo carregado em bytes: ${file.size}');

      File video = File(
        fileType.paths.first,
      );
      fileLoaded = await _handleSaveFileMessage(
        video,
      ); // Continuar verificação.
      fillChatByPressingSendButton();
    }
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
            generateImage(flag: true);
            Navigator.pop(context);
          },
          cancelOptionTitle: "Da galeria",
          onCancel: () {
            generateImage(flag: false);
            Navigator.pop(context);
          },
        );
      },
      icon: Icon(
        Icons.photo_camera,
        color: AppColors.blue,
      ),
    );
  }

  Future<void> generateImage({@required bool flag}) async {
    PickedFile pickedFile;
    if (flag) {
      pickedFile = await _picker.getImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
      File image = File(pickedFile.path);
      setState(() {
        imageCamera = image;
      });
      _handleSaveFileMessage(imageCamera);
    } else {
      pickedFile = await _picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      File image = File(pickedFile.path);
      setState(() {
        imageGallery = image;
      });
      _handleSaveFileMessage(imageGallery);
    }
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
            showMessageDialog(
              context,
              message: "Você precisa permitir ao AppCargo gravar áudio",
              type: DialogType.ERROR,
            );
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
                            _handleSaveFileMessage(audioFile);
                          } else {
                            showMessageDialog(
                              context,
                              message:
                                  ChatMessagesConstants.fileLimitErrorMessage,
                            );
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
        ),
      ),
    );
  }

  Widget _buildSendTextMessageButton(ChatState provider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {
          if (_messageTextEditingController.text.isNotEmpty &&
              _messageTextEditingController.text
                  .replaceAll(" ", "")
                  .isNotEmpty) {
            _handleSendTextMessage(
              _messageTextEditingController.text,
              provider,
            );
            fillChatByPressingSendButton();
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
      ),
    );
  }

  void _handleSendTextMessage(String text, ChatState provider) async {
    ThreadMessage message = ThreadMessage(
      content: text,
      sentByDriver: true,
      media: null,
      mediaContentType: null,
      sentAt: NTP.now().toString(),
    );

    _handleSaveMessage(message, provider);

    setState(() {
      _messageTextEditingController.text = "";
    });
  }

  void _handleSaveMessage(ThreadMessage message, ChatState provider) {
    _freightChatService.sendThreadMessage(message, _threadHash).then((_) {
      provider.isTyping = false;
    });
  }

  // Implementar try catch para feedback com o usuário

  Future<bool> _handleSaveFileMessage(File file) async {
    ThreadMessage message = ThreadMessage();

    try {
      message.media = await _freightChatService.uploadFile(file);
      if (message.media != null) {
        _freightChatService
            .sendThreadMessage(message, _threadHash)
            .catchError((e) {
          throw Exception('Exceção ao enviar o arquivo: $e');
        });
        return true;
      } else {
        throw Exception('Media com valor nulo: ${message.media}');
      }
    } catch (e) {
      throw Exception('Erro ao tentar enviar o arquivo: $e');
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
}

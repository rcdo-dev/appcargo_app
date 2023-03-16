import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/screens/chat/widgets/chat_sound_player_widget.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class ChatAudioScreen extends StatefulWidget {
  String url, dateInfo;

  ChatAudioScreen({Key key, @required this.url, this.dateInfo}) : super(key: key);

  @override
  _ChatAudioScreenState createState() =>
      _ChatAudioScreenState(url: url, dateInfo: dateInfo);
}

class _ChatAudioScreenState extends State<ChatAudioScreen> {
  String url, dateInfo;

  _ChatAudioScreenState({Key key, @required this.url, this.dateInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.green,
        title: Text(dateInfo),
      ),
      body: Center(
          child: ChatSoundPlayerWidget(
        url: url,
        isLocal: false,
        mode: PlayerMode.MEDIA_PLAYER,
      )),
    );
  }
}

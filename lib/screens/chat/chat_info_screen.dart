import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/screens/chat/chat_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class ChatInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    ChatInfo _chatInfo;
    if (null != args && args.isNotEmpty) {
      _chatInfo = args["chatInfo"] as ChatInfo;
    }

    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text("Informações da conversa"),
          backgroundColor: AppColors.green,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            color: AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _InfoBlock(
                  "Membros",
                  _chatInfo.membersName[0],
                  true,
                  values: [
                    _chatInfo.membersName[0] + " (eu)",
                    _chatInfo.membersName[1]
                  ],
                ),
                _InfoBlock(
                    "Data da última mensagem",
                    "${_chatInfo.lastSent.toDate().day.toString().padLeft(2, '0')}/"
                        "${_chatInfo.lastSent.toDate().month.toString().padLeft(2, '0')}/"
                        "${_chatInfo.lastSent.toDate().year.toString()} ${_chatInfo.lastSent.toDate().hour.toString().padLeft(2, '0')}:"
                        "${_chatInfo.lastSent.toDate().minute.toString().padLeft(2, '0')}",
                    false),
                _InfoBlock("Quantidade de mensagens",
                    "${_chatInfo.messagesQuantity}", false),
              ],
            ),
          ),
        ));
  }
}

class _InfoBlock extends StatelessWidget {
  final String title;
  final String value;
  final bool isListValue;
  final List<String> values;

  _InfoBlock(this.title, this.value, this.isListValue, {this.values});

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: SkyText(
                title,
                fontSize: 21,
                textColor: AppColors.blue,
              ),
            ),
            if (!isListValue)
              SkyText(
                value,
                fontSize: 18,
                textColor: AppColors.dark_grey,
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (String currentValue in values)
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: SkyText(
                        currentValue,
                        fontSize: 18,
                        textColor: AppColors.dark_grey,
                      ),
                    )
                ],
              )
          ]),
    );
  }
}

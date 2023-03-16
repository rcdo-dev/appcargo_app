import 'package:app_cargo/domain/new_freight/message/thread_message.dart';
import 'package:flutter/material.dart';

class ChatState extends ChangeNotifier {
  bool isTyping = false;

  List<ThreadMessage> threadMessages = new List<ThreadMessage>();

  checkUserIsTyping(bool isTyping) {
    this.isTyping = isTyping;
    notifyListeners();
  }

  fillThreadMessages(List<ThreadMessage> messages) {
    print('aqui chega?? :${messages.length}');

    for (ThreadMessage message in messages) {


      if (!threadMessages.map((item) => item.hash).contains(message.hash)) {


        threadMessages.clear();
        threadMessages.addAll(messages);

      }

    }

    notifyListeners();
  }
}

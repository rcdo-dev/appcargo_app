import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ChatInfo {
  String chatDocumentID;
  List<String> membersName;
  Timestamp lastSent;
  int messagesQuantity;

  ChatInfo(
      {@required this.chatDocumentID,
      @required this.membersName,
      @required this.lastSent,
      @required this.messagesQuantity});
}

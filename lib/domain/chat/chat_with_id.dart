import 'package:app_cargo/domain/chat/chat.dart';

class ChatWithId {
  String documentId;
  Chat chat;

  ChatWithId(this.documentId, this.chat);
}
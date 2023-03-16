import 'package:app_cargo/domain/chat/chat.dart';
import 'package:app_cargo/domain/chat/chat_with_id.dart';
import 'package:app_cargo/domain/chat/message/message.dart';

import 'chat_member.dart';

class ChatDetails  {
  ChatWithId chatWithId;

  Message lastMessage;
  ChatMember lastMessageSender;

  ChatDetails(this.chatWithId, this.lastMessage, this.lastMessageSender);
}
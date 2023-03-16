import 'package:app_cargo/domain/chat/chat.dart';
import 'package:app_cargo/domain/chat/chat_member.dart';
import 'package:app_cargo/domain/chat/chat_with_id.dart';
import 'package:app_cargo/domain/chat/message/message.dart';
import 'package:app_cargo/domain/chat/report/report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  static const String entityCollection = "entities";
  static const String chatCollection = "chats";
  static const String messageCollection = "messages";
  static const String reportCollection = "reports";

  static const String membersAttribute = "members";
  static const String hiddenAttribute = "hidden";
  static const String lastSentAttribute = "lastSent";
  static const String showToDriverAttribute = "showToDriver";
  static const String showToPartnerOrFreightCoAttribute =
      "showToPartnerOrFreightCo";

  static const String timestampAttribute = "timestamp";
  static const String contentAttribute = "content";
  static const String hashSenderAttribute = "hashSender";

  Future<Map> getChatByMembersHash(List<String> membersHash) async {
    QuerySnapshot firstMemberDocuments = await Firestore.instance
        .collection(chatCollection)
        .where(membersAttribute, arrayContains: membersHash[0])
        .getDocuments();

    for (DocumentSnapshot doc in firstMemberDocuments.documents) {
      List members = doc.data[membersAttribute];
      if (members.contains(membersHash[1])) {
        Chat chat = Chat.fromJson(doc.data);
        chat.lastSent = Timestamp.fromMillisecondsSinceEpoch(
            (doc.data[lastSentAttribute].seconds * 1000));
        Map chatMap = {"chat": chat, "chatDocumentID": doc.documentID};
        return chatMap;
      }
    }
    return null;
  }

  Future<List<ChatWithId>> getAllChatsByMemberHash(String memberHash) async {
    QuerySnapshot firstMemberDocuments = await Firestore.instance
        .collection(chatCollection)
        .where(membersAttribute, arrayContains: memberHash)
        .getDocuments();

    return firstMemberDocuments.documents.map<ChatWithId>((d) {
      Chat chat = Chat.fromJson(d.data);
      chat.lastSent = Timestamp.fromMillisecondsSinceEpoch(
          (d.data[lastSentAttribute].seconds * 1000));
      return ChatWithId(d.documentID, chat);
    }).toList();
  }

  Future<String> saveChat(Chat chat) async {
    Map jsonChatMap = Chat.toJson(chat);
    jsonChatMap[lastSentAttribute] = chat.lastSent;
    String hash = "T_${chat.members[1]}_${chat.members[0]}";
    await Firestore.instance
        .collection(chatCollection)
        .document(hash)
        .setData(jsonChatMap);
    return hash;
  }

  Future<void> saveEntity(Map entity, String hash) async {
    await Firestore.instance
        .collection(entityCollection)
        .document(hash)
        .setData(entity);
  }

  Stream getAllMessagesSnapshotsByChatDocumentID(String chatDocumentID) {
    return Firestore.instance
        .collection(chatCollection)
        .document(chatDocumentID)
        .collection(messageCollection)
        .orderBy('timestamp', descending: true)
        .where('timestamp',
            isGreaterThan:
                Timestamp.fromDate(DateTime.now().subtract(Duration(days: 5))))
        .snapshots();
  }

  Stream getChatStreamByMemberHash(String memberHash) {
    return Firestore.instance
        .collection(chatCollection)
        .where(membersAttribute, arrayContains: memberHash)
        .where('lastSent',
        isGreaterThan:
        Timestamp.fromDate(DateTime.now().subtract(Duration(days: 5))))
        .orderBy('lastSent', descending: true)
        .snapshots();
  }

  Future<void> saveMessage(
      Chat chat, Message message, String chatDocumentID) async {
    Map jsonMessageMap = Message.toJson(message);
    jsonMessageMap[timestampAttribute] = message.timestamp;
    Message.serializeToSend(jsonMessageMap);

    Firestore.instance
        .collection(chatCollection)
        .document(chatDocumentID)
        .collection(messageCollection)
        .add(jsonMessageMap);

    Map jsonChatMap = Chat.toJson(chat);
    jsonChatMap[lastSentAttribute] = message.timestamp;

    Firestore.instance
        .collection(chatCollection)
        .document(chatDocumentID)
        .updateData(jsonChatMap);
  }

  Future<void> removeMessage(String chatDocumentID, Message message) {
    Map jsonMessageMap = Message.toJson(message);
    jsonMessageMap[showToDriverAttribute] = false;
    Message.serializeToSend(jsonMessageMap);

    Firestore.instance
        .collection(chatCollection)
        .document(chatDocumentID)
        .collection(messageCollection)
        .document(message.documentID)
        .updateData(jsonMessageMap);
  }

  Future<void> removeAllMessagesFrom(String chatDocumentID) async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection(chatCollection)
        .document(chatDocumentID)
        .collection(messageCollection)
        .getDocuments();

    List<DocumentSnapshot> documents = snapshot.documents;

    for (DocumentSnapshot doc in documents) {
      Map messageMap = doc.data;
      messageMap[showToDriverAttribute] = false;

      Firestore.instance
          .collection(chatCollection)
          .document(chatDocumentID)
          .collection(messageCollection)
          .document(doc.documentID)
          .updateData(messageMap);
    }
  }

  Future<ChatMember> getOtherMemberFor(
    String currentHash,
    Chat chat,
  ) async {
    List<String> otherMembers =
        chat.members.where((hash) => hash != currentHash).toList();

    if (otherMembers.length > 0) {
      DocumentSnapshot messageSender = await Firestore.instance
          .collection(entityCollection)
          .document(otherMembers[0])
          .get();
      return ChatMember.fromJson(messageSender.data)..hash = otherMembers[0];
    }

    return null;
  }

  Future<ChatMember> getMemberByHash(String hash) async {
    await Firestore.instance
        .collection(entityCollection)
        .document(hash)
        .updateData({'name': 'Fale com a Tatá'});
    DocumentSnapshot doc = await Firestore.instance
        .collection(entityCollection)
        .document(hash)
        .get();

    return ChatMember.fromJson(doc.data)..hash = hash;
  }

  Future<int> getChatMessagesQuantity(String chatDocumentID) async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection(chatCollection)
        .document(chatDocumentID)
        .collection(messageCollection)
        .getDocuments();

    int quantity = 0;

    for (DocumentSnapshot doc in snapshot.documents) {
      if (doc.data['showToDriver'] == null) {
        quantity++;
      } else if (doc['showToDriver']) {
        quantity++;
      }
    }

    return quantity;
  }

  Future<int> getChatReceivedMessagesQuantity(
      String chatDocumentID, String driverHash) async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection(chatCollection)
        .document(chatDocumentID)
        .collection(messageCollection)
        .getDocuments();

    int quantity = 0;

    for (DocumentSnapshot doc in snapshot.documents) {
      if (doc.data['showToDriver'] == null) {
        if (doc.data['hashSender'] != driverHash) quantity++;
      } else if (doc['showToDriver']) {
        if (doc.data['hashSender'] != driverHash) quantity++;
      }
    }

    return quantity;
  }

  Future<Timestamp> getChatLastSent(String chatDocumentID) async {
    DocumentSnapshot doc = await Firestore.instance
        .collection(chatCollection)
        .document(chatDocumentID)
        .get();

    return doc.data[lastSentAttribute];
  }

  Future<String> saveReport(Report report) async {
    Map jsonReportMap = Report.toJson(report);
    jsonReportMap[timestampAttribute] = report.timestamp;
    Report.serializeToSave(jsonReportMap, report);
    String hash = "R_${report.receiverHash}_${report.message.documentID}";
    await Firestore.instance
        .collection(reportCollection)
        .document(hash)
        .setData(jsonReportMap);
    return hash;
  }
}

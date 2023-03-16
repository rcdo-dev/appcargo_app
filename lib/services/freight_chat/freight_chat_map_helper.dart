import 'package:app_cargo/domain/freight_summary/freight_summary.dart';
import 'package:app_cargo/domain/new_freight/driver_threads.dart';
import 'package:app_cargo/domain/new_freight/message/thread_message.dart';
import 'package:app_cargo/domain/thread_freight_summary/thread_freight_summary.dart';

class FreightChatMapHelper {
  static List<DriverThreads> mapToDriverThreads(List<dynamic> threads) {
    List<DriverThreads> _threadsList = new List<DriverThreads>();
    for (Map<String, dynamic> driverThreads in threads) {
      _threadsList.add(DriverThreads.fromJson(driverThreads));
    }
    return _threadsList;
  }

  static List<ThreadMessage> mapToThreadMessage(List<dynamic> messages) {
    List<ThreadMessage> _messagesList = new List<ThreadMessage>();
    for (Map<String, dynamic> driverMessages in messages) {
      _messagesList.add(ThreadMessage.fromJson(driverMessages));
    }
    return _messagesList;
  }

  static ThreadFreightSummary mapToAppCargoFreights(
      List<dynamic> listFreights) {
    // for (Map<String, dynamic> freight in listFreights) {
    //   _freights.add(ThreadFreightSummary.fromJson(freight));
    // }
    return ThreadFreightSummary.fromJson(listFreights[0]);
  }

  static ThreadMessage mapToReceiveResponseSendMessage(
      Map<String, dynamic> threadMessage) {
    return ThreadMessage.fromJson(threadMessage);
  }
}

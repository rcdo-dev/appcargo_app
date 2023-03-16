import 'package:app_cargo/domain/thread_freight_summary/thread_freight_summary.dart';

part 'driver_threads.g.dart';

class DriverThreads {
  String hash;
  String reference;
  String type;
  String lastMessageSentAt;
  int numUnreadMessages;
  bool deletedByDriver;
  ThreadFreightSummary threadFreightSummary;

  DriverThreads({
    this.hash,
    this.reference,
    this.type,
    this.lastMessageSentAt,
    this.numUnreadMessages,
    this.deletedByDriver,
    this.threadFreightSummary,
  });

  static Map<String, dynamic> toJson(DriverThreads instance) {
    return _$DriverThreadsToJson(instance);
  }

  static DriverThreads fromJson(Map<String, dynamic> json) {
    return _$DriverThreadsFromJson(json);
  }
}

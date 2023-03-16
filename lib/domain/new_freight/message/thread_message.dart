import 'package:app_cargo/domain/new_freight/message/media/media.dart';

part 'thread_message.g.dart';

class ThreadMessage {
  String hash;
  String content;
  bool sentByDriver;
  String sentAt;
  dynamic media;
  String mediaContentType;

  ThreadMessage({
    this.hash,
    this.content,
    this.sentByDriver,
    this.sentAt,
    this.media,
    this.mediaContentType,
  });

  static Map<String, dynamic> toJson(ThreadMessage instance) {
    return _$ThreadMessageToJson(instance);
  }

  static ThreadMessage fromJson(Map<String, dynamic> json) {
    return _$ThreadMessageFromJson(json);
  }
}

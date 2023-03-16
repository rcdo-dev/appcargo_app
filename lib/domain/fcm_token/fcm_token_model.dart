import 'dart:convert';

class FcmTokenModel {
  final String fcmToken;

  FcmTokenModel({
    this.fcmToken,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'fcmToken': fcmToken});

    return result;
  }

  factory FcmTokenModel.fromMap(Map<String, dynamic> map) {
    return FcmTokenModel(
      fcmToken: map['fcmToken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FcmTokenModel.fromJson(String source) =>
      FcmTokenModel.fromMap(json.decode(source));
}

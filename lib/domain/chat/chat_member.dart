
import 'package:app_cargo/domain/freight_company_summary/freight_company_summary.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_member.g.dart';

@JsonSerializable()
class ChatMember {
  String hash;
  String imageUrl;
  String name;
  String phone;

  static ChatMember fromJson(Map<String, dynamic> json) => _$ChatMemberFromJson(json ?? {});

  static ChatMember from(FreightCompanySummary freightCompanySummary) => ChatMember()
      ..hash = freightCompanySummary.accessCredentialHash
      ..phone = freightCompanySummary.contact
      ..name = freightCompanySummary.name
      ..imageUrl = freightCompanySummary.photo;
}
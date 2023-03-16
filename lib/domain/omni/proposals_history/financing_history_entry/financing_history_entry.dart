import 'package:json_annotation/json_annotation.dart';

part 'financing_history_entry.g.dart';

@JsonSerializable()
class FinancingHistoryEntry {
  String status;
  String statusText;
  String date;

  static Map<String, dynamic> toJson(
      FinancingHistoryEntry financingHistoryEntry) {
    return _$FinancingHistoryEntryToJson(financingHistoryEntry);
  }

  static FinancingHistoryEntry fromJson(Map<String, dynamic> json) {
    return _$FinancingHistoryEntryFromJson(json);
  }
}

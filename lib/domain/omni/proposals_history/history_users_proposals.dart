import 'package:app_cargo/domain/omni/proposals_history/financing_history_entry/financing_history_entry.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history_users_proposals.g.dart';

@JsonSerializable()
class HistoryUsersProposals {
  String friendlyHash;
  String licensePlate;
  @JsonKey(name: "history")
  List<FinancingHistoryEntry> financingHistoryEntry;


  static Map<String, dynamic> toJson(
      HistoryUsersProposals historyUsersProposals) {
    return _$HistoryUsersProposalsToJson(historyUsersProposals);
  }

  static HistoryUsersProposals fromJson(Map<String, dynamic> json) {
    return _$HistoryUsersProposalsFromJson(json);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_users_proposals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryUsersProposals _$HistoryUsersProposalsFromJson(
    Map<String, dynamic> json) {
  return HistoryUsersProposals()
    ..friendlyHash = json['friendlyHash'] as String
    ..licensePlate = json['licensePlate'] as String
    ..financingHistoryEntry = (json['history'] as List)
        ?.map((e) => e == null
            ? null
            : FinancingHistoryEntry.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$HistoryUsersProposalsToJson(
        HistoryUsersProposals instance) =>
    <String, dynamic>{
      'friendlyHash': instance.friendlyHash,
      'licensePlate': instance.licensePlate,
      'history': instance.financingHistoryEntry,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referrals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Referrals _$ReferralsFromJson(Map<String, dynamic> json) {
  return Referrals(
    referrals: (json['referrals'] as List)
        ?.map((e) =>
            e == null ? null : Referral.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ReferralsToJson(Referrals instance) => <String, dynamic>{
      'referrals': Referrals.referralsToJson(instance.referrals),
    };

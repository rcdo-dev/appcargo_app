// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Simulation _$SimulationFromJson(Map<String, dynamic> json) {
  return Simulation()
    ..itin = json['itin'] as String
    ..birthDate = json['birthDate'] as String
    ..phone = json['phone'] as String
    ..zipCode = json['zipCode'] as String
    ..uf = json['uf'] as String
    ..licensePlate = json['licensePlate'] as String
    ..monthlyIncome = (json['monthlyIncome'] as num)?.toDouble();
}

Map<String, dynamic> _$SimulationToJson(Simulation instance) =>
    <String, dynamic>{
      'itin': instance.itin,
      'birthDate': instance.birthDate,
      'phone': instance.phone,
      'zipCode': instance.zipCode,
      'uf': instance.uf,
      'licensePlate': instance.licensePlate,
      'monthlyIncome': instance.monthlyIncome,
    };

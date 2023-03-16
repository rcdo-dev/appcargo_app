// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fipe_model_year_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FipeModelYearDetails _$FipeModelYearDetailsFromJson(Map<String, dynamic> json) {
  return FipeModelYearDetails(
    fipeCode: json['fipe_codigo'] as String,
    vehicle: json['veiculo'] as String,
    id: json['id'] as String,
    key: json['key'] as String,
    name: json['name'] as String,
    brand: json['marca'] as String,
    modelYear: json['ano_modelo'] as String,
    reference: json['referencia'] as String,
    fuel: json['combustivel'] as String,
    price: json['preco'] as String,
    time: (json['time'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$FipeModelYearDetailsToJson(
        FipeModelYearDetails instance) =>
    <String, dynamic>{
      'fipe_codigo': instance.fipeCode,
      'combustivel': instance.fuel,
      'marca': instance.brand,
      'ano_modelo': instance.modelYear,
      'preco': instance.price,
      'key': instance.key,
      'veiculo': instance.vehicle,
      'id': instance.id,
      'referencia': instance.reference,
      'name': instance.name,
      'time': instance.time,
    };

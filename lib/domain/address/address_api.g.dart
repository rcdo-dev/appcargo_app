// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressApi _$AddressApiFromJson(Map<String, dynamic> json) {
  return AddressApi(
    cep: json['cep'] as String,
    bairro: json['bairro'] as String,
    complemento: json['complemento'] as String,
    gia: json['gia'] as String,
    ibge: json['ibge'] as String,
    localidade: json['localidade'] as String,
    logradouro: json['logradouro'] as String,
    uf: json['uf'] as String,
    unidade: json['unidade'] as String,
  );
}

Map<String, dynamic> _$AddressApiToJson(AddressApi instance) =>
    <String, dynamic>{
      'cep': instance.cep,
      'logradouro': instance.logradouro,
      'complemento': instance.complemento,
      'bairro': instance.bairro,
      'localidade': instance.localidade,
      'uf': instance.uf,
      'unidade': instance.unidade,
      'ibge': instance.ibge,
      'gia': instance.gia,
    };

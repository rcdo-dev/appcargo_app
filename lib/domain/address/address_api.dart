import 'package:json_annotation/json_annotation.dart';

part 'address_api.g.dart';

@JsonSerializable()
class AddressApi {
  String cep;
  String logradouro;
  String complemento;
  String bairro;
  String localidade;
  String uf;
  String unidade;
  String ibge;
  String gia;

  AddressApi({
    this.cep,
    this.bairro,
    this.complemento,
    this.gia,
    this.ibge,
    this.localidade,
    this.logradouro,
    this.uf,
    this.unidade,
  });
  
  static Map<String, dynamic> toJson(AddressApi addressApi){
    return _$AddressApiToJson(addressApi);
  }
  
  static AddressApi fromJson(Map<String, dynamic> json){
    return _$AddressApiFromJson(json);
  }
}

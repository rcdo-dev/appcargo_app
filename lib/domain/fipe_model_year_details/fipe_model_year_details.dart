import 'package:json_annotation/json_annotation.dart';

part 'fipe_model_year_details.g.dart';

@JsonSerializable()
class FipeModelYearDetails {
  @JsonKey(name: "fipe_codigo")
  String fipeCode;
  @JsonKey(name: "combustivel")
  String fuel;
  @JsonKey(name: "marca")
  String brand;
  @JsonKey(name: "ano_modelo")
  String modelYear;
  @JsonKey(name: "preco")
  String price;
  String key;
  @JsonKey(name: "veiculo")
  String vehicle;
  String id;
  @JsonKey(name: "referencia")
  String reference;
  String name;
  double time;

  FipeModelYearDetails({
    this.fipeCode,
    this.vehicle,
    this.id,
    this.key,
    this.name,
    this.brand,
    this.modelYear,
    this.reference,
    this.fuel,
    this.price,
    this.time,
  });

  static Map<String, dynamic> toJson(
      FipeModelYearDetails fipeModelYearDetails) {
    return _$FipeModelYearDetailsToJson(fipeModelYearDetails);
  }

  static FipeModelYearDetails fromJson(Map<String, dynamic> json) {
    return _$FipeModelYearDetailsFromJson(json);
  }
}

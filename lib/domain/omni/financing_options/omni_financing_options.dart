import 'package:json_annotation/json_annotation.dart';

part 'omni_financing_options.g.dart';

@JsonSerializable()
class OmniFinancingOptions {

  String friendlyHash;
  double totalPrice;
  // Numero de parcelas.
  int installments;

  double financedAmount;

  // Valor da parcela
  double installmentValue;
  double rate;
  // Valor da entrada.
  double inputValue;
  // Valor liquido.
  double netValue;
  double sircofValue;
  double tcValue;
  double dvValue;
  double iofValue;

  static Map<String, dynamic> toJson(OmniFinancingOptions financingOptions) {
    return _$OmniFinancingOptionsToJson(financingOptions);
  }

  static OmniFinancingOptions fromJson(Map<String, dynamic> json) {
    return _$OmniFinancingOptionsFromJson(json);
  }
}

import 'package:app_cargo/constants/converters.dart';
import 'package:app_cargo/constants/enum.dart';
import 'package:app_cargo/domain/address_summary/address_summary.dart';
import 'package:app_cargo/domain/freight_company_summary/freight_company_summary.dart';
import 'package:json_annotation/json_annotation.dart';

part 'freight_details.g.dart';

@JsonSerializable()
class FreightDetails {
  @JsonKey(toJson: AddressSummary.toJson, fromJson: AddressSummary.fromJson)
  AddressSummary from;
  @JsonKey(toJson: AddressSummary.toJson, fromJson: AddressSummary.fromJson)
  AddressSummary to;
  String code;
  String hash;
  @JsonKey(toJson: int.parse, fromJson: Converters.from)
  String distanceInMeters;
  String freightCoContact;
  @JsonKey(toJson: int.parse, fromJson: Converters.from)
  String weightInGrams;
  @JsonKey(toJson: int.parse, fromJson: Converters.from)
  String valueInCents;
  @JsonKey(toJson: int.parse, fromJson: Converters.from)
  String tollInCents;
  @JsonKey(toJson: int.parse, fromJson: Converters.from)
  String termInDays;
  @JsonKey(fromJson: FreightPaymentMethodType.fromJson, toJson: FreightPaymentMethodType.toJson)
  FreightPaymentMethodType paymentMethod;
  @JsonKey(fromJson: FreightStatus.fromJson, toJson: FreightStatus.toJson)
  FreightStatus status;
  String product;
  String species;
  String observation;
  @JsonKey(toJson: FreightCompanySummary.toJson, fromJson: FreightCompanySummary.fromJson)
  FreightCompanySummary freightCompany;

  FreightDetails({
    this.code,
    this.hash,
    this.to,
    this.from,
    this.freightCoContact,
    this.distanceInMeters,
    this.freightCompany,
    this.observation,
    this.paymentMethod,
    this.product,
    this.species,
    this.termInDays,
    this.tollInCents,
    this.valueInCents,
    this.status,
    this.weightInGrams,
  });

  static Map<String, dynamic> toJson(FreightDetails freightDetails) {
    if(freightDetails != null)
      return _$FreightDetailsToJson(freightDetails);
    else
      return null;
  }

  static FreightDetails fromJson(Map<String, dynamic> json) {
    if(json != null)
      return _$FreightDetailsFromJson(json);
    else
      return null;
  }
}


class FreightPaymentMethodType implements NamedEnum {
  final String _name;
  final String _jsonName;
  
  const FreightPaymentMethodType._(this._name, this._jsonName);
  
  @override
  String name() => _name;
  
  @override
  String uniqueName() => _jsonName;
  
  static String toJson(FreightPaymentMethodType type) => type.uniqueName();
  static FreightPaymentMethodType fromJson(String val) => FreightPaymentMethodHelper().from(val);
  
  static const ADVANCE_PLUS_BALANCE = FreightPaymentMethodType._("Adiantado + Saldo", "ADVANCE_PLUS_BALANCE");
}

class FreightPaymentMethodHelper extends EnumHelper<FreightPaymentMethodType> {
  @override
  List<FreightPaymentMethodType> values() => [
    FreightPaymentMethodType.ADVANCE_PLUS_BALANCE,
  ];
}

class FreightStatus implements NamedEnum {
  final String _name;
  final String _jsonName;
  
  const FreightStatus._(this._name, this._jsonName);
  
  @override
  String name() => _name;
  
  @override
  String uniqueName() => _jsonName;
  
  static String toJson(FreightStatus type) => type.uniqueName();
  static FreightStatus fromJson(String val) => FreightStatusHelper().from(val);

  static const OPEN = FreightStatus._("Em aberto", "OPEN");
  static const ASSIGNED = FreightStatus._("Em negociação", "ASSIGNED");
  static const STARTED = FreightStatus._("Iniciado", "STARTED");
  static const FINISHED = FreightStatus._("Finalizado", "FINISHED");
}

class FreightStatusHelper extends EnumHelper<FreightStatus> {
  @override
  List<FreightStatus> values() => [
    FreightStatus.OPEN,
    FreightStatus.ASSIGNED,
    FreightStatus.STARTED,
    FreightStatus.FINISHED,
  ];
}

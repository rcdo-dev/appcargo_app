import 'package:app_cargo/constants/enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'truck.g.dart';

@JsonSerializable()
class Truck {
  // Regex format: ^[(\w{3}-\d{9})(\w{3}\d\w\d{2})]$
  String plate;
  String renavam;
  String vin;

  // Truck model
  String modelFipeId;

  // Truck brand
  String makeFipeId;
  String modelYear;

  String truckType;
  String truckLoadType;

  Truck({
    this.plate,
    this.renavam,
    this.vin,
    this.modelFipeId,
    this.makeFipeId,
    this.modelYear,
  });

  static Map<String, dynamic> toJson(Truck truck) {
    return _$TruckToJson(truck);
  }

  static Truck fromJson(Map<String, dynamic> json) {
    return _$TruckFromJson(json);
  }
}

class TruckWeight implements NamedEnum {
  final String _name;
  final String _jsonName;

  const TruckWeight._(this._name, this._jsonName);

  @override
  String name() => _name;

  @override
  String uniqueName() => _jsonName;

  static const LIGHT = TruckWeight._("Leve", "LIGHT");
  static const MEDIUM = TruckWeight._("Medio", "MEDIUM");
  static const HEAVY = TruckWeight._("Pesado", "HEAVY");
}

class TruckWeightHelper extends EnumHelper<TruckWeight> {
  final TruckTypeHelper _truckTypes;

  TruckWeightHelper(this._truckTypes);

  @override
  List<TruckWeight> values() => [
    TruckWeight.LIGHT,
    TruckWeight.MEDIUM,
    TruckWeight.HEAVY,
  ];

  List<TruckType> typesFor(TruckWeight weight) {
    return _truckTypes
        .values()
        .where((type) => type.weight == weight)
        .toList(growable: false);
  }
}

class TruckType implements NamedEnum {
  final String _name;
  final String _jsonName;
  final TruckWeight weight;
  final String imagePath;

  const TruckType._(this._jsonName, this._name, this.weight, this.imagePath);

  @override
  String name() => _name;

  @override
  String uniqueName() => _jsonName;

  static String toJson(TruckType type) {
    if (type != null)
      return type._jsonName;
    else
      return null;
  }

  static TruckType fromJson(String val) => TruckTypeHelper().from(val);

  static const UTILITARIO = TruckType._("UTILITARIO",
      "Utilitário", TruckWeight.LIGHT, "utilitario.png");

  static const CAMINHAO_VUC = TruckType._("CAMINHAO_VUC",
      "Caminhão VUC", TruckWeight.LIGHT, "caminhao.png");

  static const CAMINHAO_3_4 = TruckType._("CAMINHAO_3_4",
      "Caminhão 3⁄4", TruckWeight.LIGHT, "caminhao_3-4.png");

  static const CAMINHAO_TOCO = TruckType._("CAMINHAO_TOCO",
      "Caminhão Toco", TruckWeight.LIGHT, "caminhao_3-4.png");

  static const CAMINHAO_TRUCK = TruckType._("CAMINHAO_TRUCK",
      "Caminhão Truck", TruckWeight.LIGHT, "caminhao-trucado.png");

  static const CAMINHAO_TRACADO = TruckType._("CAMINHAO_TRACADO",
      "Caminhão Traçado", TruckWeight.LIGHT, "caminhao-trucado.png");

  static const CAMINHAO_BITRUCK = TruckType._("CAMINHAO_BITRUCK",
      "Caminhão Bitruck", TruckWeight.MEDIUM, "caminhao-trator-semi-reboque_6-10-17.png");

  static const CAVALO_MECANICO_TOCO = TruckType._("CAVALO_MECANICO_TOCO",
      "Cavalo Mecânico Toco", TruckWeight.MEDIUM, "caminhao_3-4.png");

  static const CAVALO_MECANICO_TRUCADO = TruckType._("CAVALO_MECANICO_TRUCADO",
      "Cavalo Mecânico Trucado", TruckWeight.MEDIUM, "caminhao-trucado.png");

  static const CAVALO_MECANICO_TRACADO = TruckType._("CAVALO_MECANICO_TRACADO",
      "Cavalo Mecânico Traçado", TruckWeight.HEAVY, "caminhao-trucado.png");

  static const CAVALO_MECANICO_TRACADO_8_4 = TruckType._("CAVALO_MECANICO_TRACADO_8_4",
      "Cavalo Mecânico Traçado 8x4", TruckWeight.HEAVY, "caminhao-trator-semi-reboque_6-10-17.png");
}

class TruckTypeHelper extends EnumHelper<TruckType> {
  @override
  List<TruckType> values() => [
    TruckType.UTILITARIO,
    TruckType.CAMINHAO_VUC,
    TruckType.CAMINHAO_3_4,
    TruckType.CAMINHAO_TOCO,
    TruckType.CAMINHAO_TRUCK,
    TruckType.CAMINHAO_TRACADO,
    TruckType.CAMINHAO_BITRUCK,
    TruckType.CAVALO_MECANICO_TOCO,
    TruckType.CAVALO_MECANICO_TRUCADO,
    TruckType.CAVALO_MECANICO_TRACADO,
    TruckType.CAVALO_MECANICO_TRACADO_8_4,
  ];
}

class TruckAxles implements NamedEnum {
  final String _name;
  final String _jsonName;

  const TruckAxles._(this._jsonName, this._name);

  @override
  String name() => _name;

  @override
  String uniqueName() => _jsonName;

  static String toJson(TruckAxles axles) {
    if (axles != null)
      return axles._jsonName;
    else
      return null;
  }

  static TruckAxles fromJson(String val) {
    if (val != null)
      return TruckAxlesHelper().from(val);
    else
      return null;
  }

  static const CAVALO_MECANICO = TruckAxles._("CAVALO_MECANICO", "Só cavalo mecânico");
  static const CARRETA_2_EIXOS = TruckAxles._("CARRETA_2_EIXOS", "Carreta dois eixos");
  static const CARRETA_3_EIXOS = TruckAxles._("CARRETA_3_EIXOS", "Carreta três eixos");
  static const CARRETA_4_EIXOS = TruckAxles._("CARRETA_4_EIXOS", "Carreta quatro eixos");
  static const CARRETA_5_EIXOS = TruckAxles._("CARRETA_5_EIXOS", "Carreta cinco eixos");
  static const CARRETA_6_EIXOS = TruckAxles._("CARRETA_6_EIXOS", "Carreta seis eixos");
}

class TruckAxlesHelper extends EnumHelper<TruckAxles> {
  @override
  List<TruckAxles> values() => [
    TruckAxles.CAVALO_MECANICO,
    TruckAxles.CARRETA_2_EIXOS,
    TruckAxles.CARRETA_3_EIXOS,
    TruckAxles.CARRETA_4_EIXOS,
    TruckAxles.CARRETA_5_EIXOS,
    TruckAxles.CARRETA_6_EIXOS,
  ];
}

class TrailerType implements NamedEnum {
  final String _name;
  final String _jsonName;

  const TrailerType._(this._jsonName, this._name);

  @override
  String name() => _name;

  @override
  String uniqueName() => _jsonName;

  static String toJson(TrailerType type) {
    if (type != null)
      return type._jsonName;
    else
      return null;
  }

  static TrailerType fromJson(String val) {
    if (val != null)
      return TrailerTypeHelper().from(val);
    else
      return null;
  }

  static const ABERTO = TrailerType._("ABERTO", "Aberto");
  static const FECHADO = TrailerType._("FECHADO", "Fechado");

  static const BAU = TrailerType._("BAU", "Baú");
  static const BAU_FRIGORIFICO = TrailerType._("BAU_FRIGORIFICO", "Baú Frigorifico");
  static const SIDER = TrailerType._("SIDER", "Sider");
  static const CACAMBA = TrailerType._("CACAMBA", "Caçamba");
  static const GRADE_BAIXA = TrailerType._("GRADE_BAIXA", "Grade Baixa");
  static const GRANELEIRA = TrailerType._("GRANELEIRA", "Graneleiro");
  static const PRANCHA = TrailerType._("PRANCHA", "Prancha");
  static const TANQUE = TrailerType._("TANQUE", "Tanque");
  static const GAIOLA = TrailerType._("GAIOLA", "Gaiola");

  static const PLATAFORMA = TrailerType._("PLATAFORMA", "Plataforma");
  static const BASCULANTE = TrailerType._("BASCULANTE", "Basculante");
  static const CANAVIEIRA = TrailerType._("CANAVIEIRA", "Canavieira");
  static const FLORESTAL = TrailerType._("FLORESTAL", "Florestal");
  static const MUNCK = TrailerType._("MUNCK", "Munck");
  static const BOIADEIRA = TrailerType._("BOIADEIRA", "Boiadeira");
  static const CONTAINER = TrailerType._("CONTAINER", "Container");
}

class TrailerTypeHelper extends EnumHelper<TrailerType> {
  @override
  List<TrailerType> values() => [
    TrailerType.ABERTO,
    TrailerType.FECHADO,

    TrailerType.BAU,
    TrailerType.BAU_FRIGORIFICO,
    TrailerType.SIDER,
    TrailerType.CACAMBA,
    TrailerType.GRADE_BAIXA,
    TrailerType.GRANELEIRA,
    TrailerType.PRANCHA,
    TrailerType.TANQUE,
    TrailerType.GAIOLA,

    TrailerType.PLATAFORMA,
    TrailerType.BASCULANTE,
    TrailerType.CANAVIEIRA,
    TrailerType.FLORESTAL,
    TrailerType.MUNCK,
    TrailerType.BOIADEIRA,
    TrailerType.CONTAINER
  ];
}

class TrackerType implements NamedEnum {
  final String _name;
  final String _jsonName;

  const TrackerType._(this._jsonName, this._name);

  @override
  String name() => _name;

  @override
  String uniqueName() => _jsonName;

  static String toJson(TrackerType type) =>
      null != type ? type._jsonName : null;

  static TrackerType fromJson(String val) {
    if (val != null)
      return TrackerTypeHelper().from(val);
    else
      return null;
  }

  static const GSM = TrackerType._("GSM", "GSM");
  static const SATELLITE = TrackerType._("SATELLITE", "Satelital");
  static const RADIO = TrackerType._("RADIO", "Rádio");
}

class TrackerTypeHelper extends EnumHelper<TrackerType> {
  @override
  List<TrackerType> values() => [
    TrackerType.SATELLITE,
    TrackerType.GSM,
    TrackerType.RADIO,
  ];
}

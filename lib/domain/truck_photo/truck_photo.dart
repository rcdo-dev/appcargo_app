import 'dart:io';

import 'package:app_cargo/constants/enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'truck_photo.g.dart';

@JsonSerializable()
class TruckPhoto {

  @JsonKey(toJson: TruckPhotoType._toJson, fromJson: TruckPhotoType._fromJson)
  TruckPhotoType type;

  String photoUrl;

  @JsonKey(ignore: true)
  File photo;

  TruckPhoto({
    this.type,
    this.photoUrl,
    this.photo,
  });

  static Map<String, dynamic> toJson(TruckPhoto truckPhoto) {
    if (null != truckPhoto) return _$TruckPhotoToJson(truckPhoto);
    return {};
  }

  static TruckPhoto fromJson(Map<String, dynamic> json) {
    return _$TruckPhotoFromJson(json);
  }
}

class TruckPhotoType implements NamedEnum {
  final String _name;

  const TruckPhotoType._(this._name);

  @override
  String name() => _name;

  @override
  String uniqueName() => _name;

  static String _toJson(TruckPhotoType type) => type.name();
  static TruckPhotoType _fromJson(String val) => TruckPhotoTypeHelper().from(val);

  static const FRONT = TruckPhotoType._("FRONT");
  static const FRONT_WITH_PLATE = TruckPhotoType._("FRONT_WITH_PLATE");
  static const SIDE_1 = TruckPhotoType._("SIDE_1");
  static const SIDE_2 = TruckPhotoType._("SIDE_2");
  static const REAR = TruckPhotoType._("REAR");
  static const REAR_WITH_PLATE = TruckPhotoType._("REAR_WITH_PLATE");
}

class TruckPhotoTypeHelper extends EnumHelper<TruckPhotoType> {
  @override
  List<TruckPhotoType> values() => [
    TruckPhotoType.FRONT,
    TruckPhotoType.FRONT_WITH_PLATE,
    TruckPhotoType.SIDE_1,
    TruckPhotoType.SIDE_2,
    TruckPhotoType.REAR,
    TruckPhotoType.REAR_WITH_PLATE,
  ];
}
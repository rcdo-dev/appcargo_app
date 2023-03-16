import 'package:json_annotation/json_annotation.dart';

part 'fipe_brand.g.dart';

@JsonSerializable()
class FipeBrand {
  String name;
  String id;

  FipeBrand({
    this.name,
    this.id,
  });

  static Map<String, dynamic> toJson(FipeBrand fipeBrand) {
    return _$FipeBrandToJson(fipeBrand);
  }

  static FipeBrand fromJson(Map<String, dynamic> json) {
    return _$FipeBrandFromJson(json);
  }

  @override
  bool operator ==(other) => other is FipeBrand && this.id == other.id;

  @override
  int get hashCode => id.hashCode;
}

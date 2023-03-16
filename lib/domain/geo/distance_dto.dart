
import 'package:json_annotation/json_annotation.dart';

part 'distance_dto.g.dart';

@JsonSerializable()
class DistanceDTO {
  int distance;

  static Map<String, dynamic> toJson(DistanceDTO distanceDTO) {
    return _$DistanceDTOToJson(distanceDTO);
  }

  static DistanceDTO fromJson(Map<String, dynamic> json) {
    return _$DistanceDTOFromJson(json);
  }
}
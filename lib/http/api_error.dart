import 'package:app_cargo/http/transformers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_error.g.dart';

@JsonSerializable(
  createToJson: false,
)
class ApiError {
  String code;
  String details;

  @JsonKey(fromJson: mapFromJson)
  Map<String, dynamic> extras;

  ApiError(this.code, {this.details, this.extras});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return _$ApiErrorFromJson(json);
  }

  static List<ApiError> listFromJson(List<dynamic> list) {
    return list.map((map) => ApiError.fromJson(map)).toList();
  }

  static List<ApiError> listFromResponse(Map<String, dynamic> json) {
    if (null != json['errors']) {
      List<Map<String, dynamic>> list = List.castFrom(json['errors']);
      return listFromJson(list);
    }
    return [];
  }
}
import 'package:json_annotation/json_annotation.dart';

part 'fipe_model_summary.g.dart';

@JsonSerializable()
class FipeModelSummary {
  String name;
  String id;

  FipeModelSummary({
    this.id,
    this.name,
  });

  static Map<String, dynamic> toJson(FipeModelSummary fipeModelSummary) {
    return _$FipeModelSummaryToJson(fipeModelSummary);
  }

  static FipeModelSummary fromJson(Map<String, dynamic> json) {
    return _$FipeModelSummaryFromJson(json);
  }

  @override
  bool operator ==(other) => other is FipeModelSummary && this.id == other.id;

  @override
  int get hashCode => id.hashCode;
}

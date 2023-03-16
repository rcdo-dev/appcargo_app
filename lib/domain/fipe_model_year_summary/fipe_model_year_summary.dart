import 'package:json_annotation/json_annotation.dart';

part 'fipe_model_year_summary.g.dart';

@JsonSerializable()
class FipeModelYearSummary {
  String name;
  String id;

  FipeModelYearSummary({
    this.name,
    this.id,
  });

  static Map<String, dynamic> toJson(
      FipeModelYearSummary fipeModelYearSummary) {
    return _$FipeModelYearSummaryToJson(fipeModelYearSummary);
  }

  static FipeModelYearSummary fromJson(Map<String, dynamic> json) {
    return _$FipeModelYearSummaryFromJson(json);
  }

  @override
  bool operator ==(other) {
    if (other.id == null || this.id == null) {
      return other is FipeModelYearSummary && this.name == other.name;
    } else {
      return other is FipeModelYearSummary && this.id == other.id;
    }
  }

  @override
  int get hashCode => id.hashCode;
}

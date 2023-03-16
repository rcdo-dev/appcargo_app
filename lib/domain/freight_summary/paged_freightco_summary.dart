import 'package:app_cargo/domain/freight_company_summary/freight_company_summary.dart';
import 'package:app_cargo/http/paged_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paged_freightco_summary.g.dart';

@JsonSerializable(createToJson: false)
class PagedFreightCoSummary extends PagedResponse<FreightCompanySummary> {

  PagedFreightCoSummary();

  factory PagedFreightCoSummary.fromJson(Map<String, dynamic> json) => _$PagedFreightCoSummaryFromJson(json);

}
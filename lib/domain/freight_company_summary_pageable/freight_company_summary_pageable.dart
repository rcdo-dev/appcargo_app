import 'package:app_cargo/domain/freight_company_summary/freight_company_summary.dart';
import 'package:json_annotation/json_annotation.dart';

part 'freight_company_summary_pageable.g.dart';

@JsonSerializable()
class FreightCompanySummaryPageable{
	int recordsTotal;
	int recordsFiltered;
	bool hasNext;
	bool hasPrevious;
	@JsonKey(toJson: FreightCompanySummaryPageable.freightCompanyListToJson, fromJson: FreightCompanySummaryPageable.freightCompanyListFromJson)
	List<FreightCompanySummary> data;
	
	FreightCompanySummaryPageable({this.data, this.hasNext, this.hasPrevious, this.recordsFiltered, this.recordsTotal,});
	
	static Map<String, dynamic> toJson(FreightCompanySummaryPageable freightCompanySummaryPageable){
		return _$FreightCompanySummaryPageableToJson(freightCompanySummaryPageable);
	}
	
	static FreightCompanySummaryPageable fromJson(Map<String, dynamic> json){
		return _$FreightCompanySummaryPageableFromJson(json);
	}
	
	static dynamic freightCompanyListToJson(List<FreightCompanySummary> freightCompanySummaryList){
		List<Map<String, dynamic>> jsonFreightCompanySummaryList = new List<Map<String, dynamic>>();
		
		for(FreightCompanySummary freightCompanySummary in freightCompanySummaryList){
			jsonFreightCompanySummaryList.add(FreightCompanySummary.toJson(freightCompanySummary));
		}
		
		return jsonFreightCompanySummaryList;
	}
	
	static List<FreightCompanySummary> freightCompanyListFromJson(List<dynamic> jsonFreightCompanySummaryList){
		List<FreightCompanySummary> freightCompanySummaryList = new List<FreightCompanySummary>();
		
		for(Map<String, dynamic> jsonFreightCompanySummary in jsonFreightCompanySummaryList){
			freightCompanySummaryList.add(FreightCompanySummary.fromJson(jsonFreightCompanySummary));
		}
		
		return freightCompanySummaryList;
	}
}
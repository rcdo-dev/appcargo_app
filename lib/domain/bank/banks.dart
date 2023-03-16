import 'package:json_annotation/json_annotation.dart';

import 'bank.dart';

part 'banks.g.dart';

@JsonSerializable()
class Banks {
	
	@JsonKey(fromJson: Banks.fromBanksJson)
	List<Bank> banks;
	
	Banks({
		this.banks,
	});
	
	static Map<String, dynamic> toJson(Banks banks) {
		return _$BanksToJson(banks);
	}
	
	static Banks fromJson(Map<String, dynamic> json) {
		return _$BanksFromJson(json);
	}
	
	static List<Bank> fromBanksJson(List<dynamic> banks) {
		List<Bank> banksList = new List<Bank>();
		
		for (Map<String, dynamic> bank in banks) {
			banksList.add(Bank.fromJson(bank));
		}
		
		return banksList;
	}
}

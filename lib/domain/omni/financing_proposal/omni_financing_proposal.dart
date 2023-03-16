import 'package:json_annotation/json_annotation.dart';

part 'omni_financing_proposal.g.dart';

@JsonSerializable()
class OmniFinancingProposal {

  String refinancingOptionFriendlyHash;
  String name;
  String motherName;
  String fatherName;

  int civilState;

  // "(99)[9]9999-9999".
  String phone;
  // RG.
  String nationalId;
  // "yyyy-mm-dd"
  String nationalIdExpeditionDate;
  String nationalIdExpeditor;

  // "SP"
  String birthPlaceUF;
  // Cidade onde nasceu.
  String birthPlace;
  String country;

  String addressZipCode;
  String addressUF;
  String addressCity;
  String addressDistrict;
  String addressPlace;
  String addressNumber;
  String addressComplement;

  // Patrimonio.
  double equity;

  int professionalClass;
  int profession;

  String company;

  // "(99)[9]9999-9999".
  String companyPhone;
  String companyAddressZipCode;
  String companyAddressUF;
  String companyAddressCity;
  String companyAddressDistrict;
  String companyAddressPlace;
  String companyAddressNumber;
  String companyAddressComplement;

  static Map<String, dynamic> toJson(OmniFinancingProposal proposal) {
    return _$OmniFinancingProposalToJson(proposal);
  }

  static OmniFinancingProposal fromJson(Map<String, dynamic> json) {
    return _$OmniFinancingProposalFromJson(json);
  }

}
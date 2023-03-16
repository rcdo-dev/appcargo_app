// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'omni_submit_financing_proposal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OmniSubmitFinancingProposal _$OmniSubmitFinancingProposalFromJson(
    Map<String, dynamic> json) {
  return OmniSubmitFinancingProposal()
    ..refinancingOptionFriendlyHash =
        json['refinancingOptionFriendlyHash'] as String
    ..name = json['name'] as String
    ..motherName = json['motherName'] as String
    ..fatherName = json['fatherName'] as String
    ..civilState = json['civilState'] as int
    ..phone = json['phone'] as String
    ..nationalId = json['nationalId'] as String
    ..nationalIdExpeditionDate = json['nationalIdExpeditionDate'] as String
    ..nationalIdExpeditor = json['nationalIdExpeditor'] as String
    ..birthPlaceUF = json['birthPlaceUF'] as String
    ..birthPlace = json['birthPlace'] as String
    ..country = json['country'] as String
    ..addressZipCode = json['addressZipCode'] as String
    ..addressUF = json['addressUF'] as String
    ..addressCity = json['addressCity'] as String
    ..addressDistrict = json['addressDistrict'] as String
    ..addressPlace = json['addressPlace'] as String
    ..addressNumber = json['addressNumber'] as String
    ..addressComplement = json['addressComplement'] as String
    ..equity = (json['equity'] as num)?.toDouble()
    ..professionalClass = json['professionalClass'] as int
    ..profession = json['profession'] as int
    ..company = json['company'] as String
    ..companyPhone = json['companyPhone'] as String
    ..companyAddressZipCode = json['companyAddressZipCode'] as String
    ..companyAddressUF = json['companyAddressUF'] as String
    ..companyAddressCity = json['companyAddressCity'] as String
    ..companyAddressDistrict = json['companyAddressDistrict'] as String
    ..companyAddressPlace = json['companyAddressPlace'] as String
    ..companyAddressNumber = json['companyAddressNumber'] as String
    ..companyAddressComplement = json['companyAddressComplement'] as String;
}

Map<String, dynamic> _$OmniSubmitFinancingProposalToJson(
        OmniSubmitFinancingProposal instance) =>
    <String, dynamic>{
      'refinancingOptionFriendlyHash': instance.refinancingOptionFriendlyHash,
      'name': instance.name,
      'motherName': instance.motherName,
      'fatherName': instance.fatherName,
      'civilState': instance.civilState,
      'phone': instance.phone,
      'nationalId': instance.nationalId,
      'nationalIdExpeditionDate': instance.nationalIdExpeditionDate,
      'nationalIdExpeditor': instance.nationalIdExpeditor,
      'birthPlaceUF': instance.birthPlaceUF,
      'birthPlace': instance.birthPlace,
      'country': instance.country,
      'addressZipCode': instance.addressZipCode,
      'addressUF': instance.addressUF,
      'addressCity': instance.addressCity,
      'addressDistrict': instance.addressDistrict,
      'addressPlace': instance.addressPlace,
      'addressNumber': instance.addressNumber,
      'addressComplement': instance.addressComplement,
      'equity': instance.equity,
      'professionalClass': instance.professionalClass,
      'profession': instance.profession,
      'company': instance.company,
      'companyPhone': instance.companyPhone,
      'companyAddressZipCode': instance.companyAddressZipCode,
      'companyAddressUF': instance.companyAddressUF,
      'companyAddressCity': instance.companyAddressCity,
      'companyAddressDistrict': instance.companyAddressDistrict,
      'companyAddressPlace': instance.companyAddressPlace,
      'companyAddressNumber': instance.companyAddressNumber,
      'companyAddressComplement': instance.companyAddressComplement,
    };

import 'dart:ffi';

import 'package:app_cargo/domain/omni/submit_financing_proposal/omni_submit_financing_proposal.dart';
import 'package:app_cargo/http/transformers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class OptionFinancingSelectedFormController {
  TextEditingController driverNameController;
  TextEditingController motherNameController;
  TextEditingController fatherNameController;
  MaskedTextController driverNationalIDController;
  MaskedTextController driverNationalIDShippingDateController;
  TextEditingController driverNationalIDIssuingBodyController;
  TextEditingController driverCountryNationalityController;
  TextEditingController driverNaturalnessController;
  String driverNaturalnessFromCity;
  String driverNaturalnessFromState;

  MaskedTextController driverPhoneNumberController;
  MaskedTextController zipCodeController;
  TextEditingController placeController;
  TextEditingController residenceNumberController;
  TextEditingController residenceComplementController;
  TextEditingController districtController;

  String cityController;
  String stateController;
  MoneyMaskedTextController patrimonyValueController;

  int driverProfessionalClassController;
  int driverProfessionalTypeController;
  int driverCivilState;

  TextEditingController companyNameController;
  MaskedTextController companyPhoneNumberController;
  MaskedTextController companyAddresZipCode;

  String companyAddressCityController;
  String companyAddressUFController;

  TextEditingController companyAddressDistrictController;
  TextEditingController companyAddressPlaceController;
  TextEditingController companyAddressNumberController;
  TextEditingController companyAddressComplementController;

  TextEditingController notesController;

  OptionFinancingSelectedFormController() {
    driverNameController = new TextEditingController();
    motherNameController = new TextEditingController();
    fatherNameController = new TextEditingController();
    driverNationalIDController =
        new MaskedTextController(mask: '00.000.000-@', text: '');
    driverNationalIDShippingDateController =
        new MaskedTextController(mask: '00/00/0000', text: '');
    driverNationalIDIssuingBodyController = new TextEditingController();
    driverCountryNationalityController = new TextEditingController();
    driverNaturalnessController = new TextEditingController();

    driverPhoneNumberController =
        new MaskedTextController(mask: '(00) 0000-0000', text: '');
    driverPhoneNumberController.beforeChange = handlePhoneBeforeChange;

    zipCodeController = new MaskedTextController(mask: '00000-000', text: '');

    placeController = new TextEditingController();
    residenceNumberController = new TextEditingController();
    residenceComplementController = new TextEditingController();

    districtController = new TextEditingController();

    cityController = "São Paulo";
    stateController = "SP";

    driverNaturalnessFromCity = "São Paulo";
    driverNaturalnessFromState = "SP";

    companyAddressCityController = "São Paulo";
    companyAddressUFController = "SP";

    patrimonyValueController = new MoneyMaskedTextController(
        decimalSeparator: ',', thousandSeparator: '.');

    driverProfessionalClassController = 0;
    driverProfessionalTypeController = 0;
    driverCivilState = 0;

    companyNameController = new TextEditingController();
    companyPhoneNumberController =
        new MaskedTextController(mask: '(00) 0000-0000', text: '');
    companyPhoneNumberController.beforeChange = handlePhoneBeforeChange;

    companyAddresZipCode =
        new MaskedTextController(mask: '00000-000', text: '');

    companyAddressDistrictController = new TextEditingController();
    companyAddressPlaceController = new TextEditingController();
    companyAddressNumberController = new TextEditingController();
    companyAddressComplementController = new TextEditingController();

    notesController = new TextEditingController();
  }

  bool handlePhoneBeforeChange(String beforeChange, String afterChange) {
    print(afterChange.length);

    if (afterChange.length < 15) {
      driverPhoneNumberController.updateMask('(00) 0000-0000');
      return true;
    } else if (afterChange.length == 15) {
      driverPhoneNumberController.updateMask('(00) 00000-0000');
      return true;
    }

    return false;
  }

  OmniSubmitFinancingProposal getFinancingProposal(
      String refinancingOptionFriendlyHash) {
    OmniSubmitFinancingProposal financingProposal =
        new OmniSubmitFinancingProposal();

    financingProposal.refinancingOptionFriendlyHash =
        refinancingOptionFriendlyHash;
    financingProposal.name = this.driverNameController.text.trim();
    financingProposal.motherName = this.motherNameController.text.trim();
    financingProposal.fatherName = this.fatherNameController.text.trim();

    financingProposal.civilState = this.driverCivilState;

    financingProposal.phone = this.driverPhoneNumberController.text;

    financingProposal.nationalId = this.driverNationalIDController.text.trim();
    financingProposal.nationalIdExpeditor =
        this.driverNationalIDIssuingBodyController.text.trim();
    financingProposal.nationalIdExpeditionDate = dateToStringFromJson(
            this.driverNationalIDShippingDateController.text.trim())
        .toString()
        .split(' ')[0];

    financingProposal.birthPlaceUF = this.driverNaturalnessFromState;
    financingProposal.birthPlace = this.driverNaturalnessFromCity;

    financingProposal.country =
        this.driverCountryNationalityController.text.trim();

    financingProposal.addressZipCode = this.zipCodeController.text.trim();

    financingProposal.addressUF = this.stateController;
    financingProposal.addressCity = this.cityController;

    financingProposal.addressDistrict = this.districtController.text.trim();
    financingProposal.addressPlace = this.placeController.text.trim();
    financingProposal.addressNumber =
        this.residenceNumberController.text.trim();
    financingProposal.addressComplement = this.driverNameController.text.trim();
    financingProposal.equity = double.parse(this
        .patrimonyValueController
        .text
        .replaceAll('.', '')
        .replaceAll(',', '.'));

    financingProposal.professionalClass =
        this.driverProfessionalClassController;
    financingProposal.profession = this.driverProfessionalTypeController;

    financingProposal.company = this.companyNameController.text.trim();
    financingProposal.companyPhone =
        this.companyPhoneNumberController.text.replaceAll(' ', '');
    financingProposal.companyAddressZipCode =
        this.companyAddresZipCode.text.trim();
    financingProposal.companyAddressUF = this.companyAddressUFController.trim();
    financingProposal.companyAddressCity =
        this.companyAddressCityController.trim();
    financingProposal.companyAddressDistrict =
        this.companyAddressDistrictController.text.trim();
    financingProposal.companyAddressPlace =
        this.companyAddressPlaceController.text.trim();
    financingProposal.companyAddressNumber =
        this.companyAddressNumberController.text.trim();
    financingProposal.companyAddressComplement =
        this.companyAddressComplementController.text.trim();
    return financingProposal;
  }

  String validate() {
    if (this.driverNameController.text.trim().isEmpty ||
        this.motherNameController.text.trim().isEmpty ||
        this.fatherNameController.text.trim().isEmpty ||
        this.driverNationalIDController.text.trim().isEmpty ||
        this.driverNationalIDShippingDateController.text.trim().isEmpty ||
        this.driverNationalIDIssuingBodyController.text.trim().isEmpty ||
        this.driverCountryNationalityController.text.trim().isEmpty ||
        this.driverNaturalnessFromCity.trim().isEmpty ||
        this.driverNaturalnessFromState.trim().isEmpty ||
        this.driverPhoneNumberController.text.trim().isEmpty ||
        this.zipCodeController.text.trim().isEmpty ||
        this.placeController.text.trim().isEmpty ||
        this.residenceNumberController.text.trim().isEmpty ||
        // this.residenceComplementController.text.trim().isEmpty ||
        this.districtController.text.trim().isEmpty ||
        this.cityController.trim().isEmpty ||
        this.stateController.trim().isEmpty ||
        this.patrimonyValueController.text.trim().isEmpty ||
        this.driverProfessionalClassController == 0 ||
        this.driverProfessionalTypeController == 0 ||
        this.driverCivilState == 0 ||
        this.companyNameController.text.trim().isEmpty ||
        this.companyPhoneNumberController.text.trim().isEmpty ||
        this.companyAddresZipCode.text.trim().isEmpty ||
        this.companyAddressCityController.trim().isEmpty ||
        this.companyAddressUFController.trim().isEmpty ||
        this.companyAddressDistrictController.text.trim().isEmpty ||
        this.companyAddressPlaceController.text.trim().isEmpty ||
        // this.companyAddressComplementController.text.trim().isEmpty ||

        this.companyAddressNumberController.text.trim().isEmpty) {
      return "Preencha todos os campos";
    }

    if (this.driverCivilState == 0) {
      return "Selecione um Estado Civil!";
    }

    if (this.driverCivilState == 0) {
      return "Selecione uma Profissão!";
    }
    if (this.driverCivilState == 0) {
      return "Selecione uma Classe Profissional!";
    }

    if (this.driverPhoneNumberController.text.trim().length != 15) {
      if (this.driverPhoneNumberController.text.trim().length != 14) {
        return "Digite um número de telefone pessoal válido!";
      }
    }

    if (this.companyPhoneNumberController.text.trim().length != 15) {
      if (this.companyPhoneNumberController.text.trim().length != 14) {
        return "Digite um número de telefone da empresa válido!";
      }
    }

    if (this.zipCodeController.text.trim().length != 9) {
      return "Digite um número de CEP pessoal válido!";
    }

    if (this.companyAddresZipCode.text.trim().length != 9) {
      return "Digite um número de CEP da empresa válido!";
    }

    if (this.driverNationalIDShippingDateController.text.trim().length != 10) {
      return "Digite uma Data válida!";
    }

    return "";
  }

  String getUserAddress(String zipCodeText) {
    if (zipCodeText.replaceAll("-", "").length == 8) {
      Dio().get("https://viacep.com.br/ws/$zipCodeText/json/").then((response) {
        placeController.text = response.data["logradouro"];
        districtController.text = response.data["bairro"];
        cityController = response.data["localidade"];
        stateController = response.data["uf"];
      });
    }
  }

  getCompanyAddress(String zipCodeText) {
    if (zipCodeText.replaceAll("-", "").length == 8) {
      Dio().get("https://viacep.com.br/ws/$zipCodeText/json/").then((response) {
        companyAddressPlaceController.text = response.data["logradouro"];
        companyAddressDistrictController.text = response.data["bairro"];
        companyAddressCityController = response.data["localidade"];
        companyAddressUFController = response.data["uf"];
      });
    }
  }

  fillTextFieldForTest() {
    this.driverNameController.text = "Gabriel Luz";
    this.motherNameController.text = "Mãe";
    this.fatherNameController.text = "Pai";

    this.driverCivilState = 2;
    this.driverNationalIDController.text = "52.281.984-x";
    this.driverNationalIDShippingDateController.text = "14/04/2019";
    this.driverNationalIDIssuingBodyController.text = "SSP";
    this.driverCountryNationalityController.text = "Brasileiro";
    this.driverNaturalnessController.text = "São Paulo";
    this.driverNaturalnessFromCity = "São Paulo";
    this.driverNaturalnessFromState = "SP";

    this.driverPhoneNumberController.text = "(11)959000889";
    this.zipCodeController.text = "08410390";
    this.placeController.text = "Rua acacio Marchese";
    this.residenceNumberController.text = "116";
    this.residenceComplementController.text = "Casa 2";
    this.districtController.text = "Guaianases";

    this.cityController = "São Paulo";
    this.stateController = "SP";
    this.patrimonyValueController.text = "800000";

    this.driverProfessionalClassController = 2;
    this.driverProfessionalTypeController = 2;
    this.driverCivilState = 2;

    this.companyNameController.text = "NewGo Tecnologia";
    this.companyPhoneNumberController.text = "(11)95900-0889";
    this.companyAddresZipCode.text = "08773490";

    this.companyAddressCityController = "Mogi das Cruzes";
    this.companyAddressUFController = "SP";

    this.companyAddressDistrictController.text = "Vila Mogilar";
    this.companyAddressPlaceController.text = "Av. Pref. Carlos Ferreira Lopes";
    this.companyAddressNumberController.text = "703";
    this.companyAddressComplementController.text = "Sala 14. 8a Andar";
  }
}

part of 'settings_your_data.dart';

class SettingsYourDataController {
  // Driver's attributes
  TextEditingController alias;
  TextEditingController password;
  TextEditingController repeatPassword;
  TextEditingController name;
  MaskedTextController cellNumber;
  MaskedTextController nationalId;
  MaskedTextController registry;
  MaskedTextController birthDate;
  MaskedTextController cnh;
  DriverLicenseCategory driverLicenseCategory;
  MaskedTextController driverLicenseExpirationDate;
  MaskedTextController rntrc;
  bool hasMope;
  bool hasMercoSulPermission;
  bool hasMEI;
  bool hasCarTracker;
  bool hasCarInsurance;
  bool hasCarLocator;
  TextEditingController carTrackerName;
  TextEditingController carInsuranceName;
  TextEditingController carLocatorName;
  MaskedTextController reference1;
  MaskedTextController reference2;
  MaskedTextController reference3;
  TextEditingController previousFreightCompany1;
  TextEditingController previousFreightCompany2;
  TextEditingController previousFreightCompany3;
  Bank bank;
  TextEditingController branch;
  TextEditingController account;
  File personalPhoto;
  String personalPhotoUrl;

  SettingsYourDataController(DriverPersonalData driverPersonalData) {
    // Driver's attributes
    alias = new TextEditingController(text: driverPersonalData.alias);
    name = new TextEditingController(text: driverPersonalData.name);
    nationalId = new MaskedTextController(
        mask: "000.000.000-00", text: driverPersonalData.nationalId);
    registry = new MaskedTextController(
        mask: "@@@@@@@@@@@@@", text: driverPersonalData.registry);
    birthDate = new MaskedTextController(
        mask: "00/00/0000", text: driverPersonalData.birthDate);
    cnh = new MaskedTextController(
        mask: "00000000000", text: driverPersonalData.driverLicense.number);
    driverLicenseCategory = driverPersonalData.driverLicense.classification;
    driverLicenseExpirationDate = new MaskedTextController(
        mask: "00/00/0000",
        text: driverPersonalData.driverLicense.expirationDate);
    hasMope = driverPersonalData.hasMope;
    hasMEI = driverPersonalData.hasMEI;
    hasMercoSulPermission = driverPersonalData.hasMercoSulPermission;
    rntrc = new MaskedTextController(
        mask: "000000000", text: driverPersonalData.rntrc);
    reference1 = new MaskedTextController(
        mask: "(00) 00000-0000", text: driverPersonalData.references[0]);
    reference2 = new MaskedTextController(
        mask: "(00) 00000-0000", text: driverPersonalData.references[1]);
    reference3 = new MaskedTextController(
        mask: "(00) 00000-0000", text: driverPersonalData.references[2]);
    previousFreightCompany1 = new TextEditingController(
        text: driverPersonalData.previousFreightCompanies[0]);
    previousFreightCompany2 = new TextEditingController(
        text: driverPersonalData.previousFreightCompanies[1]);
    previousFreightCompany3 = new TextEditingController(
        text: driverPersonalData.previousFreightCompanies[2]);
    
    if(driverPersonalData.bank != null)
      if(driverPersonalData.bank.name != null)
        if(driverPersonalData.bank.code != "")
          bank = driverPersonalData.bank;
    
    branch = new TextEditingController(text: driverPersonalData.branch);
    account = new TextEditingController(text: driverPersonalData.account);

    personalPhoto = null;
    personalPhotoUrl = driverPersonalData.personalPhotoUrl;
  }

  DriverPersonalData getDriverPersonalData() {
    return new DriverPersonalData(
      personalPhoto: personalPhoto,
      alias: alias.text,
      name: name.text,
      hasMope: hasMope,
      hasMEI: hasMEI,
      nationalId: nationalId.text,
      birthDate: birthDate.text,
      registry: registry.text,
      driverLicense: new DriverLicense(
        number: cnh.text,
        classification: driverLicenseCategory,
        expirationDate: driverLicenseExpirationDate.text,
      ),
      rntrc: rntrc.text,
      references: [
        reference1.text,
        reference2.text,
        reference3.text,
      ],
      previousFreightCompanies: [
        previousFreightCompany1.text,
        previousFreightCompany2.text,
        previousFreightCompany3.text
      ],
      account: account.text,
      branch: branch.text,
      bank: bank,
    );
  }

  String strategy() {
    String errors = "";

    if (alias.text.trim() == "") {
      errors = "O apelido é obrigatório\n";
    }

    if (!CPFValidator.isValid(nationalId.text.trim())) {
      errors =  "O CPF ${nationalId.text.trim()} é inválido";
    }

    if (nationalId.text.trim() == "") {
      errors = "O CPF é obrigatório\n";
    }

    return errors;
  }
}

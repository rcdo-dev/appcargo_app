part of 'settings_contact.dart';

class SettingsContactDataController {
  MaskedTextController contactCepController;
  TextEditingController contactStreetController;
  TextEditingController contactNumberController;
  TextEditingController contactNeighborhoodController;
  String contactStateAcronymController;
  City contactCityController;
  MaskedTextController contactCellNumberController;
  TextEditingController socialFacebookController;
  TextEditingController socialInstagramController;
  TextEditingController emergencyNameController;
  TextEditingController emergencyRelationController;
  MaskedTextController emergencyNumberController;

  SettingsContactDataController(DriverContactUpdate driverContactUpdate) {
    this.contactCepController = new MaskedTextController(
        mask: "00000-000", text: driverContactUpdate.contact.cep);
    this.contactStreetController =
        new TextEditingController(text: driverContactUpdate.contact.street);
    this.contactNumberController = new TextEditingController(text: driverContactUpdate.contact.number);
    this.contactNeighborhoodController = new TextEditingController(
        text: driverContactUpdate.contact.neighborhood);
    this.contactStateAcronymController =
        driverContactUpdate.contact.state.acronym;
    this.contactCityController = driverContactUpdate.contact.city;
    this.contactCellNumberController = new MaskedTextController(
        mask: "(00) 00000-0000", text: driverContactUpdate.contact.cellNumber);
    this.socialFacebookController =
        new TextEditingController(text: driverContactUpdate.social.facebook);
    this.socialInstagramController =
        new TextEditingController(text: driverContactUpdate.social.instagram);
    this.emergencyNameController =
        new TextEditingController(text: driverContactUpdate.emergency.name);
    this.emergencyRelationController =
        new TextEditingController(text: driverContactUpdate.emergency.relation);
    this.emergencyNumberController = new MaskedTextController(
        mask: "(00) 00000-0000",
        text: driverContactUpdate.emergency.cellNumber);
  }
  
  void fillControllersWithNewAddressApi(AddressApi addressApi){
    this.contactStreetController = new TextEditingController(text: addressApi.logradouro);
    this.contactNeighborhoodController = new TextEditingController(text: addressApi.bairro);
    this.contactStateAcronymController = addressApi.uf;
    this.contactCityController = new City(name: addressApi.localidade);
    return;
  }

  DriverContactUpdate getDriverContactUpdate(
      DriverContactData driverContactData,
      DriverEmergencyData driverEmergencyData,
      DriverSocialData driverSocialData) {
    return new DriverContactUpdate(
      contact: driverContactData,
      emergency: driverEmergencyData,
      social: driverSocialData,
    );
  }

  DriverContactData getDriverContactData() {
    return new DriverContactData(
        city: this.contactCityController,
        state: new AddressState(acronym: this.contactStateAcronymController),
        cellNumber: this.contactCellNumberController.text,
        cep: this.contactCepController.text,
        neighborhood: this.contactNeighborhoodController.text,
        street: this.contactStreetController.text,
        number: this.contactNumberController.text);
  }

  DriverEmergencyData getDriverEmergencyData() {
    return new DriverEmergencyData(
        cellNumber: this.emergencyNumberController.text,
        name: this.emergencyNameController.text,
        relation: this.emergencyRelationController.text);
  }

  DriverSocialData getDriverSocialData() {
    return new DriverSocialData(
        facebook: this.socialFacebookController.text,
        instagram: this.socialInstagramController.text);
  }
}

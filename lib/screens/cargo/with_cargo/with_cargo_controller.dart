part of 'with_cargo.dart';

class WithCargoController {
  MaskedTextController howLong;
  City city;

  WithCargoController() {
    howLong = new MaskedTextController(mask: "000", text: "");
  }

  ChangeTruckStatusData getChangeTruckStatusData() {
    return ChangeTruckStatusData(
      cityHash: city.hash,
      howLong: int.parse(howLong.text),
    );
  }
}

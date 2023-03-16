class CRLV {
  String licensePlate;
  String renavam;
  String vin;

  CRLV({this.licensePlate, this.renavam, this.vin});

  int howManyDetected() {
    int howManyDetected = 0;
    if (null != licensePlate && licensePlate.trim().isNotEmpty) {
      howManyDetected++;
    }
    if (null != renavam && renavam.trim().isNotEmpty) {
      howManyDetected++;
    }
    if (null != vin && vin.trim().isNotEmpty) {
      howManyDetected++;
    }
    return howManyDetected;
  }

  bool hasDetectedNothing() {
    return 0 == this.howManyDetected();
  }

  bool hasDetectedPart() {
    int howManyDetected = this.howManyDetected();
    return howManyDetected > 0 && howManyDetected < 3;
  }

  bool hasDetectedEverything() {
    return 3 == this.howManyDetected();
  }
}

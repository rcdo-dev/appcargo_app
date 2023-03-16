class CNH {
  String name;

  String registry;
  String nationalId;

  String birthDate;

  String category;
  String number;
  String validity;

  CNH(
      {this.name,
      this.registry,
      this.nationalId,
      this.birthDate,
      this.category,
      this.number,
      this.validity});

  int howManyDetected() {
    int howManyDetected = 0;
    if (null != name && name.trim().isNotEmpty) {
      howManyDetected++;
    }
    if (null != registry && registry.trim().isNotEmpty) {
      howManyDetected++;
    }
    if (null != nationalId && nationalId.trim().isNotEmpty) {
      howManyDetected++;
    }
    if (null != birthDate && birthDate.trim().isNotEmpty) {
      howManyDetected++;
    }
    if (null != category && category.trim().isNotEmpty) {
      howManyDetected++;
    }
    if (null != number && number.trim().isNotEmpty) {
      howManyDetected++;
    }
    if (null != validity && validity.trim().isNotEmpty) {
      howManyDetected++;
    }
    return howManyDetected;
  }

  bool hasDetectedNothing() {
    return 0 == this.howManyDetected();
  }

  bool hasDetectedPart() {
    int howManyDetected = this.howManyDetected();
    return howManyDetected > 1 && howManyDetected < 4;
  }

  bool hasDetectedMostPart() {
    int howManyDetected = this.howManyDetected();
    return howManyDetected >= 4 && howManyDetected < 7;
  }

  bool hasDetectedEverything() {
    return 7 == this.howManyDetected();
  }
}

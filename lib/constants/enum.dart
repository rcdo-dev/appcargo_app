abstract class NamedEnum {
  String name();
  String uniqueName();
}

abstract class EnumHelper<T extends NamedEnum> {
  List<T> values();
  T from(String val) {
    if (null == val || val.trim().isEmpty) {
      return null;
    }

    for (T el in this.values()) {
      if (el.uniqueName() == val) return el;
    }

    throw "InvalidState! Inexistent enum value: [" + val + "]";
  }
}

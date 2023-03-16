import 'package:app_cargo/constants/text_masks.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class Formatter {
  Formatter._();

  static String meterToKilometer(num number) {
    return number.toString() + " Km";
  }

  static String gramsToKilo(num number) {
    number = number / 1000;
    return number.toStringAsFixed(3) + " Kg";
  }

  static String gramsToTon(num number) {
    print(number);
    number = number / 1000;
    number = number / 1000;
    print(number);
    return number.toStringAsFixed(3) + " Ton";
  }
  
  static String days(num number){
    return number.toString() + " dias";
  }

  static String phone(String phone){
    MaskedTextController mask = new MaskedTextController(mask: Mask.phone, text: phone);
    return mask.text;
  }

  static final currency =
      NumberFormat.currency(name: "R\$", decimalDigits: 2, locale: "pt_BR");
}

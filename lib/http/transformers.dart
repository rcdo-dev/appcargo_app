import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

String genericStringCleaner(String data) =>
    (data ?? "").replaceAll(RegExp(r'[-.() ]'), '');

String dateToJson(DateTime dateTime) =>
    formatDate(dateTime, [dd, '/', mm, '/', yyyy]);

DateTime dateFromJson(String date) {
  if (date != null) {
    List<String> dateFields = date.split("/");

    if (dateFields.length == 3) {
      return DateTime.parse(
          dateFields[2] + "-" + dateFields[1] + "-" + dateFields[0]);
    }
  }

  return null;
}

String dateToStringFromJson(String date) {
  if (date != null) {
    List<String> dateFields = date.split("/");

    if (dateFields.length == 3) {
      return dateFields[2] + "-" + dateFields[1] + "-" + dateFields[0];
    }
  }
  return null;
}

List<String> phoneListToJson(List<String> phones) =>
    phones.map(genericStringCleaner).toList();

Map<String, dynamic> mapFromJson(dynamic map) {
  if (map is Map<String, dynamic>) {
    return map;
  }

  return {};
}

String formatCurrencyValue(double currencyValue) {
  return NumberFormat.currency(locale: 'pt-BR', name: "R\$")
      .format(currencyValue);
}

double convertStringToDouble(String value) {
  String replacedValue = value.replaceAll('.', '').replaceAll(",", ".");
  return double.parse(replacedValue);
}

bool checkInvalidDriverAge(String date) {
  int yearDiff = DateTime.now().year - dateFromJson(date).year;
  if (yearDiff > 18 && yearDiff < 120) {
    return false;
  }
  return true;
}

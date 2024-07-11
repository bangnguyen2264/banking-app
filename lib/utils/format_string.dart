import 'package:intl/intl.dart';

String hideNumberAccount(String number) {
  if (number.length > 2) {
    return '**** **** ${number.substring(number.length - 2)}';
  }
  return number;
}

String formatMoney(int value) {
  NumberFormat formatter = NumberFormat('#,### VND');
  return formatter.format(value);
}
String formatDate(String date) {
  DateTime dateTime = DateTime.parse(date);
  return DateFormat('dd/MM/yyyy').format(dateTime);
}

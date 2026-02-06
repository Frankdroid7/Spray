import 'package:intl/intl.dart';

String formatCurrency(dynamic amount, [bool doubleDigits = true]) {
  NumberFormat format = NumberFormat(
    '##,##${doubleDigits ? "0.00" : "0"}',
    'en_US',
  );
  amount = amount ?? "0.00";
  num value = amount.runtimeType == String
      ? format.parse(amount).toDouble()
      : amount;

  return format.format(value);
}

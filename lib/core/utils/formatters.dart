import 'package:intl/intl.dart';

String formatTons(num value) =>
    NumberFormat.decimalPattern('it_IT').format(value);

String formatPercent(num value) => '${value.toStringAsFixed(0)}%';

String formatCurrencyEuro(num monthly) =>
    NumberFormat.currency(locale: 'it_IT', symbol: '€').format(monthly);

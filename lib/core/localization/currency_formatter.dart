import 'package:intl/intl.dart';

/// Formatter for Bangladeshi Taka (BDT ৳) with South Asian Lakh/Crore comma formatting
class CurrencyFormatter {
  CurrencyFormatter._();

  static const Map<String, String> _banglaDigits = {
    '0': '০',
    '1': '১',
    '2': '২',
    '3': '৩',
    '4': '৪',
    '5': '৫',
    '6': '৬',
    '7': '৭',
    '8': '৮',
    '9': '৯',
  };

  /// Format an amount into Bangladeshi Taka format (e.g. ৳ 25,50,000 or ৳ ২৫,৫০,০০০)
  static String format(num amount, {bool isBangla = false, bool includeSymbol = true, bool compact = false}) {
    if (compact) {
      return formatCompact(amount, isBangla: isBangla, includeSymbol: includeSymbol);
    }

    final isNegative = amount < 0;
    final absAmount = amount.abs().round();
    final str = absAmount.toString();

    String formatted;
    if (str.length <= 3) {
      formatted = str;
    } else {
      final lastThree = str.substring(str.length - 3);
      final remaining = str.substring(0, str.length - 3);

      final buffer = StringBuffer();
      for (int i = 0; i < remaining.length; i++) {
        if (i > 0 && (remaining.length - i) % 2 == 0) {
          buffer.write(',');
        }
        buffer.write(remaining[i]);
      }
      formatted = '${buffer.toString()},$lastThree';
    }

    if (isBangla) {
      formatted = toBanglaDigits(formatted);
    }

    final symbol = includeSymbol ? '৳ ' : '';
    final sign = isNegative ? '-' : '';
    return '$sign$symbol$formatted';
  }

  /// Compact representation e.g. ৳ 25.5L or ৳ ১.৫ কোটি
  static String formatCompact(num amount, {bool isBangla = false, bool includeSymbol = true}) {
    final abs = amount.abs();
    final symbol = includeSymbol ? '৳ ' : '';

    if (abs >= 10000000) {
      final crore = (amount / 10000000).toStringAsFixed(2);
      final unit = isBangla ? ' কোটি' : ' Cr';
      return '$symbol${isBangla ? toBanglaDigits(crore) : crore}$unit';
    } else if (abs >= 100000) {
      final lakh = (amount / 100000).toStringAsFixed(2);
      final unit = isBangla ? ' লাখ' : ' Lakh';
      return '$symbol${isBangla ? toBanglaDigits(lakh) : lakh}$unit';
    } else if (abs >= 1000) {
      final k = (amount / 1000).toStringAsFixed(1);
      final unit = isBangla ? ' হাজার' : 'K';
      return '$symbol${isBangla ? toBanglaDigits(k) : k}$unit';
    }

    return format(amount, isBangla: isBangla, includeSymbol: includeSymbol);
  }

  /// Converts English digits in a string to Bengali digits
  static String toBanglaDigits(String input) {
    String output = input;
    _banglaDigits.forEach((en, bn) {
      output = output.replaceAll(en, bn);
    });
    return output;
  }

  /// Formats date
  static String formatDate(DateTime date, {bool isBangla = false}) {
    final formatter = DateFormat('dd MMM yyyy');
    final formatted = formatter.format(date);
    return isBangla ? toBanglaDigits(formatted) : formatted;
  }
}

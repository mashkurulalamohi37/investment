import 'package:intl/intl.dart';

/// Formatter for Bangladeshi Taka (BDT ৳) with South Asian Lakh/Crore grouping
/// and thin space (৳\u2009) separation (§5 of Khatian Specification)
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

  /// Bangla short month names, indexed 1-12 (Jan = index 1)
  static const List<String> _banglaMonthsShort = [
    '', 'জানু', 'ফেব', 'মার্চ', 'এপ্রিল', 'মে', 'জুন',
    'জুলাই', 'আগস্ট', 'সেপ্ট', 'অক্টো', 'নভে', 'ডিসে',
  ];

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

    final symbol = includeSymbol ? '৳\u2009' : '';
    final sign = isNegative ? '-' : '';
    return '$sign$symbol$formatted';
  }

  /// Compact representation e.g. ৳ 25.5L or ৳ ১.৫ কোটি
  static String formatCompact(num amount, {bool isBangla = false, bool includeSymbol = true}) {
    final abs = amount.abs();
    final symbol = includeSymbol ? '৳\u2009' : '';

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

  /// Formats date. Never mixes scripts: Bangla mode uses Bangla digits AND
  /// Bangla month names; English mode uses Latin digits and English months.
  static String formatDate(DateTime date, {bool isBangla = false}) {
    if (isBangla) {
      final day = toBanglaDigits(date.day.toString());
      final month = _banglaMonthsShort[date.month];
      final year = toBanglaDigits(date.year.toString());
      return '$day $month $year';
    }
    return DateFormat('dd MMM yyyy').format(date);
  }

  /// Day+month only, e.g. "12 Feb" / "১২ ফেব" — for compact ledger date columns.
  static String formatDayMonth(DateTime date, {bool isBangla = false}) {
    if (isBangla) {
      final day = toBanglaDigits(date.day.toString());
      final month = _banglaMonthsShort[date.month];
      return '$day $month';
    }
    return DateFormat('dd MMM').format(date);
  }

  /// Year only, respecting script.
  static String formatYear(DateTime date, {bool isBangla = false}) {
    final year = date.year.toString();
    return isBangla ? toBanglaDigits(year) : year;
  }
}

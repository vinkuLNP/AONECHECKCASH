import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat('#,##0', 'en_US');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll(',', '');

    if (text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    if (!RegExp(r'^\d+$').hasMatch(text)) {
      return oldValue;
    }

    if (text.length > 8) {
      return oldValue;
    }

    final formatted = _formatter.format(int.parse(text));

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }


}


class CurrencyFormatter {
  static final NumberFormat _formatter = NumberFormat('#,##0', 'en_US');

  static String format(num? value) {
    if (value == null) return '';
    return _formatter.format(value);
  }

  static String formatString(String? value) {
    if (value == null || value.trim().isEmpty) return '';

    final number = int.tryParse(value.replaceAll(',', ''));
    if (number == null) return value;

    return _formatter.format(number);
  }
}
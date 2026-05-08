import 'package:a1_check_cashers/core/constants/app_keys.dart';

class AppValidators {
  static String? requiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    return null;
  }

  static String? validateName(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    if (value.trim().length > 50) {
      return '$fieldName cannot exceed 50 characters';
    }

    final regex = AppKeys.charactersOnlyValidator;

    if (!regex.hasMatch(value.trim())) {
      return '$fieldName can contain only letters';
    }

    return null;
  }

  static String? validatePhone(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
      return '$fieldName must be 10 digits';
    }

    return null;
  }

  static String? validateChequeNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Cheque number is required';
    }

    if (!RegExp(r'^\d{1,15}$').hasMatch(value.trim())) {
      return 'Cheque number must be up to 15 digits';
    }

    return null;
  }

  static String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Cheque amount is required';
    }

    if (!RegExp(r'^\d{1,15}$').hasMatch(value.trim())) {
      return 'Amount must be up to 15 digits';
    }

    return null;
  }

  static String? validateNotes(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    //    if (value == null || value.trim().isEmpty) {
    //   return 'Additional notes are required';
    // }

    if (value.length > 500) {
      return 'Additional notes cannot exceed 500 characters';
    }

    final htmlRegex = RegExp(r'<[^>]*>');

    if (htmlRegex.hasMatch(value)) {
      return 'HTML tags are not allowed';
    }

    return null;
  }
}

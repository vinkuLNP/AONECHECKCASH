import 'package:a1_check_cashers/core/constants/app_keys.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';

class AppValidators {
  static String? requiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 
      
      '$fieldName ${AppStrings.isRequired}';
    }

    return null;
  }

  static String? validateName(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName ${AppStrings.isRequired}';
    }

    if (value.trim().length > 50) {
      return '$fieldName ${AppStrings.cannotExceed50Characters}';
    }

    final regex = AppKeys.charactersOnlyValidator;

    if (!regex.hasMatch(value.trim())) {
      return '$fieldName ${AppStrings.canOnlyContainLettersAndSpaces}';
    }

    return null;
  }

  static String? validatePhone(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName ${AppStrings.isRequired}';
    }

    if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
      return '$fieldName ${AppStrings.mustBe10Digits}';
    }

    return null;
  }

  static String? validateChequeNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.chequeNumberRequired;
    }

    if (!RegExp(r'^\d{1,15}$').hasMatch(value.trim())) {
      return AppStrings.chequeNumberMustBeUpTo15Digits;
    }

    return null;
  }

  static String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.chequeAmountRequired;
    }

  
  final cleaned = value.trim();

  final amount = double.tryParse(cleaned);

  if (amount == null) {
    return AppStrings.enterValidAmount;
  }

  final digitsOnly = cleaned.replaceAll('.', '');

  if (digitsOnly.length > 15) {
    return AppStrings.amountMustBeUpTo15Digits;
  }

  return null;
}

  static String? otherChequeType(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.otherChequeTypeRequired;
    }

    return null;
  }

  static String? validateNotes(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    if (value.length > 500) {
      return AppStrings.additionalNotesCannotExceed500Characters;
    }

    final htmlRegex = RegExp(r'<[^>]*>');

    if (htmlRegex.hasMatch(value)) {
      return AppStrings.htmlTagsAreNotAllowed;
    }

    return null;
  }
}

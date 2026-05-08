import 'package:a1_check_cashers/core/constants/app_strings.dart';

class AuthValidator {
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.nameRequired;
    }
    if (value.trim().length < 3) {
      return AppStrings.invalidName;
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.emailRequired;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return AppStrings.invalidEmail;
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.phoneRequired;
    }

    final phoneRegex = RegExp(r'^[0-9]{10}$');

    if (!phoneRegex.hasMatch(value.trim())) {
      return AppStrings.invalidPhone;
    }

    return null;
  }

  static String? loginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired;
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired;
    }
    final errors = <String>[];

    if (value.length < 6) {
      errors.add(AppStrings.passwordMinLength);
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      errors.add(AppStrings.mustIncludeUppercase);
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      errors.add(AppStrings.mustIncludeNumber);
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      errors.add(AppStrings.mustIncludeSpecialCharacter);
    }

    if (errors.isNotEmpty) {
      return errors.join('\n');
    }

    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return AppStrings.confirmPasswordRequired;
    }

    if (value != password) {
      return AppStrings.passwordMismatch;
    }

    return null;
  }
}

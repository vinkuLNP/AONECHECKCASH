import 'dart:developer';

import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/core/session_manager/session_manager.dart';
import 'package:a1_check_cashers/features/auth/domain/enitities/user_entity.dart';
import 'package:a1_check_cashers/features/auth/domain/usecases/signup_usecase.dart';
import 'package:flutter/material.dart';
import '../../domain/usecases/login_usecase.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;

  AuthProvider(this.loginUseCase, this.signupUseCase);

  bool isLoading = false;
  User? user;

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool rememberMe = false;

  String? activeField;

  void setActiveField(String field) {
    activeField = field;
    notifyListeners();
  }

  void clearActiveField() {
    activeField = null;
    notifyListeners();
  }

  void togglePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  void toggleRememberMe(bool value) {
    rememberMe = value;
    notifyListeners();
  }

  Future<String?> login(String email, String password) async {
    _setLoading(true);

    try {
      user = await loginUseCase(email, password);
      await SessionManager.saveSession(userId: user!.id, token: user!.token);
      return AppStrings.loginSuccessful;
    } catch (e) {
      debugPrint("Login Error: $e");
      return _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<String?> signup(
    String name,
    String email,
    // String phone,
    String password,
  ) async {
    _setLoading(true);

    try {
      user = await signupUseCase(
        email,
        password,
        name, //phone
      );

      return AppStrings.signupSuccessful;
    } catch (e) {
      log("Signup Error: $e");
      return _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  String _handleError(dynamic e) {
    final message = e.toString();

    if (message.contains("invalid-credentials") ||
        message.contains("validate_login_incorrect") ||
        message.contains("Email or password incorrect")) {
      return AppStrings.loginFailed;
    } else if (message.contains("email-already-in-use")) {
      return AppStrings.emailAlreadyExists;
    } else if (message.contains("network")) {
      return AppStrings.noInternet;
    }

    return AppStrings.smthngWntWrong;
    // return message;
  }

  void reset() {
    user = null;
    isLoading = false;
    obscurePassword = true;
    obscureConfirmPassword = true;
    rememberMe = false;
    activeField = null;
    notifyListeners();
  }
}

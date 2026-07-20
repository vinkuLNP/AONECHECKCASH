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
  User? _user;
  User? user;
  bool _isLoggedIn = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool rememberMe = false;
  bool get isLoggedIn => _isLoggedIn;
  String? activeField;
  User? get loginUser => _user;
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

  Future<void> initialize() async {
    _isLoggedIn = await SessionManager.isLoggedIn();

    if (_isLoggedIn) {
      _user = User(
        id: await SessionManager.getUserId() ?? "",
        name: await SessionManager.getUserName() ?? "",
        token: await SessionManager.getToken() ?? "",
        clientRecordId: await SessionManager.getClientRecordId() ?? "",
        email: await SessionManager.getUserEmail() ?? "",
      );
    }

    notifyListeners();
  }

  Future<String?> login(String email, String password) async {
    _setLoading(true);
    try {
      user = await loginUseCase(email, password);
      if (user!.clientRecordId.isEmpty) {
        return "Client record not found";
      }

      await SessionManager.saveSession(
        userId: user!.id,
        token: user!.token,
        clientRecordId: user!.clientRecordId,
      );
      _user = user;
      _isLoggedIn = true;
      return AppStrings.loginSuccessful;
    } catch (e) {
      return _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<String?> signup(String name, String email, String password) async {
    _setLoading(true);

    try {
      user = await signupUseCase(email, password, name);

      return AppStrings.signupSuccessful;
    } catch (e) {
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
    log('Error: $message'); // Log the error message for debugging
    return 
    // message; // Return the actual error message for other cases
    AppStrings.smthngWntWrong;
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

  Future<void> logout() async {
    await SessionManager.clearSession();

    _user = null;
    user = null;
    _isLoggedIn = false;

    notifyListeners();
  }
}

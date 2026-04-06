import 'package:a1_check_cashers/features/auth/presentation/pages/login_screen.dart';
import 'package:a1_check_cashers/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:a1_check_cashers/features/home_page/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';

class AppRouter {
  static Map<String, WidgetBuilder> routes = {
    AppRoutes.home: (context) => const HomePage(),
    AppRoutes.login: (context) => LoginScreen(),
    AppRoutes.signup: (context) => SignupScreen(),
  };
}

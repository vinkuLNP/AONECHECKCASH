import 'package:a1_check_cashers/features/home_page/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';

class AppRouter {
  static Map<String, WidgetBuilder> routes = {
    AppRoutes.home: (context) => const HomePage(),
  };
}

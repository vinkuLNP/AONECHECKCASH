import 'package:flutter/material.dart';

class MoneyServiceItem {
  final String title;
  final String description;
  final String buttonText;
  final IconData icon;
  final bool isDark;

  const MoneyServiceItem({
    required this.title,
    required this.description,
    required this.buttonText,
    required this.icon,
    required this.isDark,
  });
}

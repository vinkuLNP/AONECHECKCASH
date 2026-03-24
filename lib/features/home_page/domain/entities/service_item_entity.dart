import 'package:flutter/material.dart';

class ServiceItem {
  final String title;
  final String desc;
  final IconData icon;
  final VoidCallback onTap;

  ServiceItem({
    required this.title,
    required this.desc,
    required this.icon,
    required this.onTap,
  });
}

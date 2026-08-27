import 'package:flutter/material.dart';

class BusinessServiceEntity {
  final String title;
  final String description;
  final String buttonText;
  final IconData icon;

  const BusinessServiceEntity({
    required this.title,
    required this.description,
    required this.buttonText,
    required this.icon,
  });
}

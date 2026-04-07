import 'package:flutter/material.dart';

Color getStatusColor(String status) {
  switch (status) {
    case "Approved":
      return Colors.green;
    case "Rejected":
      return Colors.red;
    default:
      return Colors.orange;
  }
}

import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

enum ChequeStatus { underReview, needMoreInfo, approved, rejected }

extension ChequeStatusExtension on ChequeStatus {
  String get status {
    switch (this) {
      case ChequeStatus.underReview:
        return AppStrings.underReview;
      case ChequeStatus.needMoreInfo:
        return AppStrings.needMoreInfo;
      case ChequeStatus.approved:
        return AppStrings.approved;
      case ChequeStatus.rejected:
        return AppStrings.rejected;
    }
  }

  Color get statusColor {
    switch (this) {
      case ChequeStatus.underReview:
        return Colors.grey.shade700;
      case ChequeStatus.needMoreInfo:
        return Colors.orange.shade700;
      case ChequeStatus.approved:
        return Colors.green.shade700;
      case ChequeStatus.rejected:
        return Colors.red.shade700;
    }
  }

  IconData get statusIcon {
    switch (this) {
      case ChequeStatus.underReview:
        return Icons.access_time;
      case ChequeStatus.needMoreInfo:
        return Icons.error_outline;
      case ChequeStatus.approved:
        return Icons.check_circle;
      case ChequeStatus.rejected:
        return Icons.cancel;
    }
  }

  int get statusPriority {
    switch (this) {
      case ChequeStatus.needMoreInfo:
        return 0;
      case ChequeStatus.approved:
        return 1;
      case ChequeStatus.underReview:
        return 2;
      case ChequeStatus.rejected:
        return 3;
    }
  }
}

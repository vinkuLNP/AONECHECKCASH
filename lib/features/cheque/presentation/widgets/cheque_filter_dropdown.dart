import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/features/cheque/presentation/provider/cheque_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/enum/cheque_status_enum.dart';

class ChequeFilterDropdown extends StatelessWidget {
  const ChequeFilterDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChequeFormProvider>(
      builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<ChequeStatus?>(
                value: provider.currentFilter,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                hint: Row(
                  children: const [
                    Icon(Icons.filter_list, size: 18),
                    SizedBox(width: 6),
                   AppText(text: AppStrings.filter),
                  ],
                ),
                onChanged: provider.setFilter,
                items: [
                  _buildDropdownItem(null, AppStrings.all),

                  ...ChequeStatus.values.map(
                    (status) => _buildDropdownItem(status, status.status),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

DropdownMenuItem<ChequeStatus?> _buildDropdownItem(
  ChequeStatus? status,
  String title,
) {
  return DropdownMenuItem(
    value: status,
    child: Row(
      children: [
        if (status != null)
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: status.statusColor,
              shape: BoxShape.circle,
            ),
          ),
        AppText(text: title, fontSize: 14),
      ],
    ),
  );
}

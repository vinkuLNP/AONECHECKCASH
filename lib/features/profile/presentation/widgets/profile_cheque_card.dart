import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/features/cheque/presentation/screens/cheque_screen_main.dart';
import 'package:a1_check_cashers/features/profile/presentation/widgets/profile_card.dart';
import 'package:a1_check_cashers/features/cheque/domain/enum/cheque_form_mode_enum.dart';
import 'package:a1_check_cashers/features/cheque/domain/enum/cheque_status_enum.dart';
import 'package:a1_check_cashers/features/cheque/presentation/provider/cheque_provider.dart';
import 'package:a1_check_cashers/features/cheque/presentation/screens/cheque_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:provider/provider.dart';

class ProfileChequeCard extends StatelessWidget {
  final ChequeFormProvider provider;
  const ProfileChequeCard(this.provider, {super.key});

  @override
  Widget build(BuildContext context) {
    final grouped = provider.groupedCheques;
    return ProfileCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AppText(
                      text: AppStrings.cheques,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: AppButton(
                    text: AppStrings.addCheque,
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              EditChequeScreen(mode: ChequeFormMode.create),
                        ),
                      );

                      if (result == true && context.mounted) {
                        await context.read<ChequeFormProvider>().loadCheques();
                      }
                    },
                    icon: Icon(Icons.add, color: AppColors.whiteColor),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: ChequeStatus.values.map((status) {
              final count = grouped[status]?.length ?? 0;

              return _row(status.status, status.statusColor, count.toString());
            }).toList(),
          ),
          const Divider(),

          GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChequeListScreen()),
              );

              if (context.mounted) {
                await context.read<ChequeFormProvider>().loadCheques();
              }
            },
            child: ListTile(
              title: const AppText(
                text: AppStrings.manageChecks,
                fontWeight: FontWeight.w600,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String title, Color color, String count) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: AppText(
              text: title,
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          AppText(text: count, fontWeight: FontWeight.bold),
        ],
      ),
    );
  }
}

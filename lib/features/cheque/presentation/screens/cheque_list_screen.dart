import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/features/cheque/domain/enum/cheque_form_mode_enum.dart';
import 'package:a1_check_cashers/features/cheque/presentation/provider/cheque_provider.dart';
import 'package:a1_check_cashers/features/cheque/presentation/screens/cheque_card.dart';
import 'package:a1_check_cashers/features/cheque/presentation/screens/cheque_screen_main.dart';
import 'package:a1_check_cashers/features/cheque/presentation/widgets/cheque_filter_dropdown.dart';
import 'package:a1_check_cashers/features/cheque/presentation/widgets/empty_cheque_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChequeListScreen extends StatelessWidget {
  const ChequeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cheques = context.watch<ChequeFormProvider>().cheques;

    return Scaffold(
      appBar: AppBar(
        title: AppText(text: AppStrings.cheques, color: AppColors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await context.read<ChequeFormProvider>().loadCheques();
            },
          ),
          ChequeFilterDropdown(),
        ],
      ),
      floatingActionButton: cheques.isEmpty
          ? null
          : FloatingActionButton(
              backgroundColor: AppColors.primary,
              onPressed: () =>
                  _navigateToEdit(context, mode: ChequeFormMode.create),
              child: Icon(Icons.add, color: AppColors.whiteColor),
            ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          await context.read<ChequeFormProvider>().loadCheques();
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween(begin: 0.95, end: 1.0).animate(animation),
                child: child,
              ),
            );
          },
          child: cheques.isEmpty
              ? const EmptyChequeView()
              : ListView.builder(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 60),
                  itemCount: cheques.length,
                  itemBuilder: (_, i) {
                    final cheque = cheques[i];
                    return ChequeCard(
                      cheque: cheque,
                      onEdit: () {
                        _navigateToEdit(
                          context,
                          cheque: cheque,
                          mode: ChequeFormMode.edit,
                        );
                      },
                      onView: () {
                        _navigateToEdit(
                          context,
                          cheque: cheque,
                          mode: ChequeFormMode.view,
                        );
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }

  void _navigateToEdit(
    BuildContext context, {
    dynamic cheque,
    ChequeFormMode? mode,
  }) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            EditChequeScreen(cheque: cheque, mode: mode ?? ChequeFormMode.view),
      ),
    );

    if (result == true && context.mounted) {
      await context.read<ChequeFormProvider>().loadCheques();
    }
  }
}

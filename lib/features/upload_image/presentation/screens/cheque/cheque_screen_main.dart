import 'package:a1_check_cashers/core/di/service_locator.dart';
import 'package:a1_check_cashers/features/upload_image/domain/entities/cheque_entity.dart';
import 'package:a1_check_cashers/features/upload_image/domain/enum/cheque_form_mode_enum.dart';
import 'package:a1_check_cashers/features/upload_image/presentation/provider/cheque_provider.dart';
import 'package:a1_check_cashers/features/upload_image/presentation/screens/cheque/edit_cheque_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditChequeScreen extends StatelessWidget {
  final Cheque? cheque;
  final ChequeFormMode mode;
  const EditChequeScreen({
    super.key,
    this.cheque,
    this.mode = ChequeFormMode.create,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<ChequeFormProvider>()..initialize(cheque, mode),

      child: const EditChequeView(),
    );
  }
}

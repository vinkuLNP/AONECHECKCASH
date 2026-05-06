import 'package:a1_check_cashers/core/di/service_locator.dart';
import 'package:a1_check_cashers/features/upload_image/domain/entities/cheque_entity.dart';
import 'package:a1_check_cashers/features/upload_image/presentation/provider/cheque_provider.dart';
import 'package:a1_check_cashers/features/upload_image/presentation/screens/cheque/edit_cheque_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditChequeScreen extends StatelessWidget {
  final Cheque? cheque;

  const EditChequeScreen({super.key, this.cheque});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<ChequeFormProvider>()..initialize(cheque),

      child: const EditChequeView(),
    );
  }
}

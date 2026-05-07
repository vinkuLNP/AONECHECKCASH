import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/features/profile/presentation/provider/profile_provider.dart';
import 'package:a1_check_cashers/features/profile/presentation/widgets/identity_card.dart';
import 'package:a1_check_cashers/features/profile/presentation/widgets/profile_cheque_card.dart';
import 'package:a1_check_cashers/features/profile/presentation/widgets/profile_header.dart';
import 'package:a1_check_cashers/features/profile/presentation/widgets/top_background.dart';
import 'package:a1_check_cashers/features/upload_image/presentation/provider/cheque_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().loadProfile();
      context.read<ChequeFormProvider>().loadCheques();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.heroColor,
      body: Consumer2<ProfileProvider, ChequeFormProvider>(
        builder: (_, profile, cheque, __) {
          return Stack(
            children: [
              const TopBackground(),
              SafeArea(
                child: ListView(
                  padding: const EdgeInsets.only(top: 40, bottom: 24),
                  children: [
                    ProfileHeader(profile),
                    SizedBox(height: 24),
                    IdentityCard(profile),
                    SizedBox(height: 20),
                    ProfileChequeCard(cheque),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

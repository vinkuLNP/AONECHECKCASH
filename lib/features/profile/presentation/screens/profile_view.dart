import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/core/routes/app_routes.dart';
import 'package:a1_check_cashers/features/profile/presentation/provider/profile_provider.dart';
import 'package:a1_check_cashers/features/profile/presentation/widgets/identity_card.dart';
import 'package:a1_check_cashers/features/profile/presentation/widgets/profile_card.dart';
import 'package:a1_check_cashers/features/profile/presentation/widgets/profile_cheque_card.dart';
import 'package:a1_check_cashers/features/profile/presentation/widgets/profile_header.dart';
import 'package:a1_check_cashers/features/profile/presentation/widgets/top_background.dart';
import 'package:a1_check_cashers/features/cheque/presentation/provider/cheque_provider.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _refreshAllData();
    });
  }

  Future<void> _refreshAllData() async {
    await Future.wait([
      context.read<ProfileProvider>().loadProfile(),
      context.read<ChequeFormProvider>().loadCheques(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.heroColor,
      body: Consumer2<ProfileProvider, ChequeFormProvider>(
        builder: (_, profile, cheque, __) {
          final isLoading = profile.isLoading || cheque.isLoading;

          return Stack(
            children: [
              AbsorbPointer(
                absorbing: isLoading,
                child: Opacity(
                  opacity: isLoading ? 0.4 : 1,
                  child: Stack(
                    children: [
                      const TopBackground(),
                      SafeArea(
                        child: RefreshIndicator(
                          color: AppColors.primary,
                          onRefresh: _refreshAllData,

                          child: ListView(
                            padding: const EdgeInsets.only(top: 40, bottom: 24),
                            children: [
                              ProfileHeader(profile),
                              SizedBox(height: 24),
                              IdentityCard(profile),
                              SizedBox(height: 20),
                              ProfileChequeCard(cheque),
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () => showLogoutDialog(context, profile),
                                child: ProfileCard(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.logout,
                                        color: AppColors.primary,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 16),
                                      const AppText(
                                        text: AppStrings.logOut,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, top: 12),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              color: Colors.white.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(14),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(14),
                                onTap: () {
                                  if (Navigator.canPop(context)) {
                                    Navigator.pop(context);
                                  } else {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      AppRoutes.home,
                                    );
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (isLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.15),
                  child: const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> showLogoutDialog(
    BuildContext context,
    ProfileProvider profile,
  ) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const AppText(text: AppStrings.logOut),
          content: const AppText(text: AppStrings.wantToLogout),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const AppText(text: AppStrings.cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const AppText(
                text: AppStrings.logOut,
                color: AppColors.primary,
              ),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true && context.mounted) {
      await profile.logout(context);
    }
  }
}

import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/core/utils/network_info.dart';
import 'package:a1_check_cashers/features/auth/presentation/provider/auth_provider.dart';
import 'package:a1_check_cashers/features/profile/presentation/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:a1_check_cashers/core/constants/app_assets.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/routes/app_routes.dart';
import 'package:a1_check_cashers/core/session_manager/session_manager.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _navigateToNextScreen();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  Future<void> _navigateToNextScreen() async {
    if (!await NetworkInfo().hasInternetConnection()) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No internet connection available."),
            duration: Duration(seconds: 6),
          ),
        );
      }
    }

    await Future.delayed(const Duration(seconds: 3));

    final auth = context.read<AuthProvider>();
    await auth.initialize();
    if (!auth.isLoggedIn) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
      return;
    }

    try {
      final profile = context.read<ProfileProvider>();

      await profile.getProfile(auth.loginUser!.clientRecordId);

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.profileView,
        (route) => false,
      );
    } catch (_) {
      await SessionManager.clearSession();
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(child: Image.asset(storeImage, fit: BoxFit.cover)),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Hero(
                          tag: 'app_logo',
                          child: Image.asset(appLogo, width: 140),
                        ),

                        const SizedBox(height: 20),
                        AppText(
                          text: AppStrings.subtitle.toUpperCase(),
                          textAlign: TextAlign.center,
                          color: AppColors.whiteColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(westernUnionLogo, width: 42),

                            const SizedBox(width: 8),

                            AppText(
                              text: AppStrings.westernUnion,
                              color: AppColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        const SizedBox(
                          height: 26,
                          width: 26,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

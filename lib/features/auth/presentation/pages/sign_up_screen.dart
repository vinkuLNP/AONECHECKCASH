import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/app_widgets/input_fields.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/routes/app_routes.dart';
import 'package:a1_check_cashers/features/auth/presentation/auth_validator.dart';
import 'package:a1_check_cashers/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/top_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/app_widgets/app_common_text_widget.dart';
import '../provider/auth_provider.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.heroColor,
      body: SafeArea(
        child: Column(
          children: [
            const TopHeader(showDrawer: false),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      const AppText(
                        text: AppStrings.createAccount,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 8),

                      const AppText(
                        text: AppStrings.signupSubtitle,
                        color: AppColors.textLight,
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 20),

                      authContainer(
                        child: Form(
                          key: _formKey,
                          child: Consumer<AuthProvider>(
                            builder: (_, provider, __) {
                              return Column(
                                children: [
                                  AppInputField(
                                    label: AppStrings.fullName,
                                    controller: nameController,
                                    hint: AppStrings.enterFullName,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,

                                    validator: (value) {
                                      if (provider.activeField ==
                                          AppStrings.fullName) {
                                        return null;
                                      }
                                      return AuthValidator.name(value);
                                    },

                                    onTap: () {
                                      provider.setActiveField(
                                        AppStrings.fullName,
                                      );
                                    },

                                    onChanged: (_) {
                                      provider.setActiveField(
                                        AppStrings.fullName,
                                      );
                                    },

                                    onFieldSubmitted: (_) {
                                      provider.clearActiveField();
                                    },
                                  ),

                                  const SizedBox(height: 16),

                                  AppInputField(
                                    label: AppStrings.email,
                                    controller: emailController,
                                    hint: AppStrings.enterYourEmail,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,

                                    validator: (value) {
                                      if (provider.activeField ==
                                          AppStrings.email) {
                                        return null;
                                      }
                                      return AuthValidator.email(value);
                                    },

                                    onTap: () {
                                      provider.setActiveField(AppStrings.email);
                                    },

                                    onChanged: (_) {
                                      provider.setActiveField(AppStrings.email);
                                    },

                                    onFieldSubmitted: (_) {
                                      provider.clearActiveField();
                                    },
                                  ),

                                  const SizedBox(height: 16),

                                  AppPasswordField(
                                    label: AppStrings.password,
                                    controller: passwordController,
                                    obscure: provider.obscurePassword,
                                    maxLength: 20,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,

                                    validator: (value) {
                                      if (provider.activeField ==
                                          AppStrings.password) {
                                        return null;
                                      }
                                      return AuthValidator.password(value);
                                    },

                                    onToggle: provider.togglePassword,

                                    onTap: () {
                                      provider.setActiveField(
                                        AppStrings.password,
                                      );
                                    },

                                    onChanged: (_) {
                                      provider.setActiveField(
                                        AppStrings.password,
                                      );
                                    },

                                    onFieldSubmitted: (_) {
                                      provider.clearActiveField();
                                    },
                                  ),

                                  const SizedBox(height: 16),

                                  AppPasswordField(
                                    label: AppStrings.confirmPassword,
                                    controller: confirmPasswordController,
                                    obscure: provider.obscureConfirmPassword,
                                    maxLength: 20,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,

                                    validator: (value) {
                                      if (provider.activeField ==
                                          AppStrings.confirmPassword) {
                                        return null;
                                      }

                                      return AuthValidator.confirmPassword(
                                        value,
                                        passwordController.text,
                                      );
                                    },

                                    onToggle: provider.toggleConfirmPassword,

                                    onTap: () {
                                      provider.setActiveField(
                                        AppStrings.confirmPassword,
                                      );
                                    },

                                    onChanged: (_) {
                                      provider.setActiveField(
                                        AppStrings.confirmPassword,
                                      );
                                    },

                                    onFieldSubmitted: (_) {
                                      provider.clearActiveField();
                                    },
                                  ),

                                  const SizedBox(height: 20),

                                  AppButton(
                                    text: AppStrings.createAccount,
                                    isLoading: provider.isLoading,
                                    onPressed: () async {
                                      provider.clearActiveField();

                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      }

                                      final message = await provider.signup(
                                        nameController.text.trim(),
                                        emailController.text.trim(),
                                        passwordController.text.trim(),
                                      );

                                      if (message != null && context.mounted) {
                                        final isSuccess =
                                            message ==
                                            AppStrings.signupSuccessful;

                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(message),
                                            backgroundColor: isSuccess
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        );

                                        if (isSuccess) {
                                          Navigator.pushReplacementNamed(
                                            context,
                                            AppRoutes.login,
                                          );
                                        }
                                      }
                                    },
                                  ),

                                  const SizedBox(height: 20),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const AppText(
                                        text: AppStrings.alreadyHaveAccount,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            AppRoutes.login,
                                          );
                                        },
                                        child: const AppText(
                                          text: AppStrings.signIn,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      termsAndPrivacy(),
                      backToHomeButton(context),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

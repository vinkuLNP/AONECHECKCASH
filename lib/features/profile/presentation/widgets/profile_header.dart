import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/features/profile/presentation/provider/profile_provider.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileProvider p;
  const ProfileHeader(this.p, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 12,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 42,
            backgroundColor: Colors.white,
            child: AppText(
              text: p.user == null
                  ? ""
                  : p.user!.name.substring(0, 2).toUpperCase(),
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 12),
        AppText(
          text: p.user?.name ?? "",
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        const SizedBox(height: 4),
        AppText(
          text: p.user?.email ?? "",
          color: Colors.white.withValues(alpha: 0.85),
          fontSize: 13,
        ),
      ],
    );
  }
}

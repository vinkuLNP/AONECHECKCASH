import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';

class TopHeader extends StatelessWidget {
  const TopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: const Color(0xFF0B1B2B),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: const [
              AppText(
                text: AppStrings.openToday,
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 2),
              AppText(
                text: AppStrings.nearestLocation,
                color: Colors.white70,
                fontSize: 12,
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  AppText(
                    text: AppStrings.appName,

                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 2),
                  AppText(
                    text: AppStrings.subtitle,
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ],
              ),

              const Spacer(),

              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, size: 26),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

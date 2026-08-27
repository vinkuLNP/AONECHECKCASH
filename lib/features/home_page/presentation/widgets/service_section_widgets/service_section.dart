import 'dart:developer';

import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/features/home_page/data/data_sources/services_card_local_data.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/service_section_widgets/service_card.dart';
import 'package:flutter/material.dart';

class ServiceSection extends StatelessWidget {
  const ServiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final services = ServicesLocalData.getServices();

    return Container(
      color: AppColors.heroColor,
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 1;
          log('constraints.maxWidth: ${constraints.maxWidth}');
          if (constraints.maxWidth > 900) {
            crossAxisCount = 4;
          } else if (constraints.maxWidth > 600) {
            crossAxisCount = 3;
            } else if (constraints.maxWidth > 500) {
              crossAxisCount = 2;
          } else if (constraints.maxWidth > 400) {
            crossAxisCount = 1;
          }

          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: services.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio:
                  constraints.maxWidth > 300 && constraints.maxWidth < 350
                  ? 1.28
                  : constraints.maxWidth > 350 && constraints.maxWidth < 400
                  ? 1.5
                  : crossAxisCount == 1
                  ? 1.8
                  : 1,
            ),
            itemBuilder: (context, index) {
              return ServiceCard(item: services[index]);
            },
          );
        },
      ),
    );
  }
}

import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/features/home_page/data/data_sources/customer_support_data.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/customer_support_widgets/support_card.dart';
import 'package:flutter/material.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';

class CustomerSupportSection extends StatelessWidget {
  const CustomerSupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = CustomerSupportLocalData.getItems();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: AppStrings.needHelp,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),

          const SizedBox(height: 12),

          AppText(
            text: AppStrings.contactA1,
            fontSize: 15,
            color: AppColors.textLight,
          ),

          const SizedBox(height: 22),

          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 900;
              final isTablet = constraints.maxWidth >= 600;

              if (isDesktop) {
                return Row(
                  children: items
                      .map(
                        (item) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: SupportCard(item: item),
                          ),
                        ),
                      )
                      .toList(),
                );
              }

              if (isTablet) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (context, index) {
                    return SupportCard(item: items[index]);
                  },
                );
              }

              return SizedBox(
                height: 130,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 130,
                      child: SupportCard(item: items[index]),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

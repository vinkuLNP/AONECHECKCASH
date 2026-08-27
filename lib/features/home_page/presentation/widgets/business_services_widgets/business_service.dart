import 'package:a1_check_cashers/features/home_page/data/data_sources/business_services_local_data.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/business_services_widgets/business_card.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/business_services_widgets/business_header.dart';
import 'package:flutter/material.dart';

class BusinessServicesSection extends StatelessWidget {
  const BusinessServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = BusinessServicesLocalData().getServices();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 900;
        final isTablet =
            constraints.maxWidth >= 600 && constraints.maxWidth < 900;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 40),
          color: const Color(0xFFF9FAFB),
          child: Column(
            children: [
              const BusinessHeader(),
              const SizedBox(height: 28),

              if (isDesktop)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: items
                        .map(
                          (item) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: BusinessCard(item: item),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
              else if (isTablet)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.1,
                        ),
                    itemBuilder: (context, index) {
                      return BusinessCard(item: items[index]);
                    },
                  ),
                )
              else
                SizedBox(
                  height: 260,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 14),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 280,
                        child: BusinessCard(item: items[index]),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

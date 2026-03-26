import 'package:a1_check_cashers/features/home_page/data/data_sources/quick_services_local_data.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/everyday_quick_services_widgets/quick_service_card.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/everyday_quick_services_widgets/section_header.dart';
import 'package:flutter/material.dart';

class EverydayServicesQuickSection extends StatelessWidget {
  const EverydayServicesQuickSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = QuickServicesLocalData().getServices();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 900;
        final isTablet =
            constraints.maxWidth >= 600 && constraints.maxWidth < 900;

        if (isDesktop) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 10, 24, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(),
                const SizedBox(height: 20),
                Row(
                  children: items
                      .map(
                        (item) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: QuickServiceCard(item: item),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          );
        }

        if (isTablet) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(),
                const SizedBox(height: 18),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 1.15,
                  ),
                  itemBuilder: (context, index) {
                    return QuickServiceCard(item: items[index]);
                  },
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 0, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: SectionHeader(),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 280,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(right: 16),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 280,
                      child: QuickServiceCard(item: items[index]),
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

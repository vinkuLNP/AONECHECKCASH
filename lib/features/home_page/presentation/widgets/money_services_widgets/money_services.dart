import 'dart:async';
import 'package:a1_check_cashers/features/home_page/data/data_sources/money_services_local_data.dart';
import 'package:a1_check_cashers/features/home_page/domain/entities/money_service_entity.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/money_services_widgets/money_service_card.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class MoneyServicesCarouselSection extends StatefulWidget {
  const MoneyServicesCarouselSection({super.key});

  @override
  State<MoneyServicesCarouselSection> createState() =>
      _MoneyServicesCarouselSectionState();
}

class _MoneyServicesCarouselSectionState
    extends State<MoneyServicesCarouselSection> {
  late final PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  late final List<MoneyServiceItem> items;

  @override
  void initState() {
    super.initState();

    items = MoneyServicesLocalData.getItems();

    _pageController = PageController(viewportFraction: 0.92);

    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_pageController.hasClients) return;

      _currentPage = (_currentPage + 1) % items.length;

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),

        SizedBox(
          height: 420,
          child: PageView.builder(
            controller: _pageController,
            itemCount: items.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: MoneyServiceCard(item: items[index]),
              );
            },
          ),
        ),

        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            items.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: _currentPage == index ? 24 : 8,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? AppColors.primary
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),
      ],
    );
  }
}

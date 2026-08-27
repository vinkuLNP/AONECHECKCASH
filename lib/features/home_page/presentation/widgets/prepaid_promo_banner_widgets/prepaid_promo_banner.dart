import 'package:a1_check_cashers/features/home_page/presentation/widgets/prepaid_promo_banner_widgets/prepaid_card.dart';
import 'package:flutter/material.dart';

class PrepaidPromoBannerSection extends StatelessWidget {
  const PrepaidPromoBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFFB91C1C), Color(0xFFE11D48)],
        ),
      ),
      child: const PrepaidCard(),
    );
  }
}

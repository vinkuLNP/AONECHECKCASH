import 'package:a1_check_cashers/features/home_page/presentation/widgets/auto_services.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/business_services_widgets/business_service.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/career_stripe.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/customer_support_widgets/customer_support.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/everyday_quick_services_widgets/everyday_services_quick_section.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/hero_widget.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/highlight_section.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/location_finder.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/money_services_widgets/money_services.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/prepaid_promo_banner_widgets/prepaid_promo_banner.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/service_section_widgets/service_section.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/top_header.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/why_choose_widgets/why_choose_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        TopHeader(),
        HeroWidget(),
        ServiceSection(),
        WhyChoose(),
        HighlightSection(),
        MoneyServicesCarouselSection(),
        EverydayServicesQuickSection(),
        BusinessServicesSection(),
        PrepaidPromoBannerSection(),
        LocationFinderSection(),
        AutoServicesSection(),
        CareersStripSection(),
        CustomerSupportSection(),
      ],
    );
  }
}

import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/hero_widget.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/service_section_widgets/service_section.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/top_header.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.whiteColor,
          elevation: 2,
          toolbarHeight: 144,
          flexibleSpace: SafeArea(
            child: SizedBox(height: 144, child: TopHeader()),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            HeroWidget(),
            ServiceSection(),
         /*   WhyChoose(),
            HighlightSection(),
            MoneyServicesCarouselSection(),
            EverydayServicesQuickSection(),
            BusinessServicesSection(),
            PrepaidPromoBannerSection(),
            LocationFinderSection(),
            AutoServicesSection(),
            CareersStripSection(),
            CustomerSupportSection(),*/
            SizedBox(height: 60),
          ]),
        ),
      ],
    );
  }
}

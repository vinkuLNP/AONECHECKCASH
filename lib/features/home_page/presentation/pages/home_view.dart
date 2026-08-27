import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/features/home_page/presentation/controller/home_controller.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/hero_widget.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/service_section_widgets/service_section.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/top_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<HomeController>().isLoading;
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.heroColor,
              elevation: 2,
              toolbarHeight: 150,
              flexibleSpace: SafeArea(
                child: SizedBox(height: 150, child: TopHeader()),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                HeroWidget(),
                // const AppVersionWidget(),
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
                Container(color: AppColors.heroColor, height: 70),
              ]),
            ),
          ],
        ),
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),

              child: Center(
                child: CircularProgressIndicator(color: AppColors.primaryDark),
              ),
            ),
          ),
      ],
    );
  }
}

import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/features/home_page/data/data_sources/why_choosE_local_data.dart';
import 'package:a1_check_cashers/features/home_page/domain/entities/why_choose_item.dart';
import 'package:a1_check_cashers/features/home_page/presentation/widgets/why_choose_widgets/why_item.dart';
import 'package:flutter/material.dart';

class WhyChoose extends StatefulWidget {
  const WhyChoose({super.key});

  @override
  State<WhyChoose> createState() => _WhyChooseState();
}

class _WhyChooseState extends State<WhyChoose>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late List<WhyChooseItem> items;

  @override
  void initState() {
    super.initState();

    items = WhyChooseLocalData.getItems();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whyChooseWidgetColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          const AppText(
            text: AppStrings.whyChooseTitle,
            textAlign: TextAlign.center,
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
          ),

          const SizedBox(height: 12),

          const AppText(
            text: AppStrings.whyChooseDesc,
            textAlign: TextAlign.center,
            fontSize: 15,
            height: 1.6,
            color: AppColors.textLight,
          ),

          const SizedBox(height: 24),

          Column(
            children: List.generate(items.length, (index) {
              final animation = Tween(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: controller,
                  curve: Interval((index * 0.1), 1.0, curve: Curves.easeOut),
                ),
              );

              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.2),
                    end: Offset.zero,
                  ).animate(animation),
                  child: WhyItem(
                    item: items[index],
                    lastItem: index == items.length - 1,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

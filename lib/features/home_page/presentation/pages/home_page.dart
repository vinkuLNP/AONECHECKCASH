import 'package:a1_check_cashers/features/drawer/presentation/screen/app_drawer.dart';
import 'package:a1_check_cashers/features/home_page/presentation/pages/home_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: AppDrawer(),
      body: HomeView(),
    );
  }
}
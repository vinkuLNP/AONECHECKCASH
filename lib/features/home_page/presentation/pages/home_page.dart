import 'package:a1_check_cashers/features/home_page/presentation/controller/home_controller.dart';
import 'package:a1_check_cashers/features/home_page/presentation/pages/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: AppDrawer(),
      body: ChangeNotifierProvider(
        create: (_) => HomeController(),
        child: HomeView(),
      ),
    );
  }
}

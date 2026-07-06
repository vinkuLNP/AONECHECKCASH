import 'package:a1_check_cashers/core/di/service_locator.dart';
import 'package:a1_check_cashers/core/routes/app_router.dart';
import 'package:a1_check_cashers/core/routes/app_routes.dart';
import 'package:a1_check_cashers/features/auth/presentation/provider/auth_provider.dart';
import 'package:a1_check_cashers/features/profile/presentation/provider/business_check_provider.dart';
import 'package:a1_check_cashers/features/profile/presentation/provider/profile_provider.dart';
import 'package:a1_check_cashers/features/cheque/presentation/provider/cheque_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => sl<DrawerProvider>()),
        ChangeNotifierProvider(create: (_) => sl<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => sl<ChequeFormProvider>()),
        ChangeNotifierProvider(create: (_) => sl<BusinessCheckProvider>()),
        ChangeNotifierProvider(create: (_) => sl<ProfileProvider>()),
      ],

      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        routes: AppRouter.routes,
      ),
    );
  }
}
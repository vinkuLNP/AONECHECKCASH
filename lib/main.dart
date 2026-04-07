import 'package:a1_check_cashers/core/di/service_locator.dart';
import 'package:a1_check_cashers/core/routes/app_router.dart';
import 'package:a1_check_cashers/core/routes/app_routes.dart';
import 'package:a1_check_cashers/features/auth/presentation/provider/auth_provider.dart';
import 'package:a1_check_cashers/features/drawer/presentation/provider/drawer_provider.dart';
import 'package:a1_check_cashers/features/upload_image/presentation/provider/upload_provider.dart';
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
        ChangeNotifierProvider(create: (_) => sl<DrawerProvider>()),
        ChangeNotifierProvider(create: (_) => sl<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => sl<UploadProvider>()),
      ],

      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.home,
        routes: AppRouter.routes,
      ),
    );
  }
}

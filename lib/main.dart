import 'package:a1_check_cashers/core/routes/app_router.dart';
import 'package:a1_check_cashers/core/routes/app_routes.dart';
import 'package:a1_check_cashers/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:a1_check_cashers/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:a1_check_cashers/features/auth/domain/usecases/login_usecase.dart';
import 'package:a1_check_cashers/features/auth/domain/usecases/signup_usecase.dart';
import 'package:a1_check_cashers/features/auth/presentation/provider/auth_provider.dart';
import 'package:a1_check_cashers/features/drawer/presentation/provider/drawer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final remote = AuthRemoteDataSource();
  final repo = AuthRepositoryImpl(remote);
  final loginUseCase = LoginUseCase(repo);
  final signUpUseCase = SignupUseCase(repo);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DrawerProvider()),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(loginUseCase, signUpUseCase),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      routes: AppRouter.routes,
    );
  }
}

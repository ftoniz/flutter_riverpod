import 'package:flutter/material.dart';
import 'package:ft_flutter_riverpod/router/app_router.dart';
import 'package:ft_flutter_riverpod/constant/colors.dart';

class FlutterRiverPodApp extends StatelessWidget with AppRouter {
  const FlutterRiverPodApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'Flutter River Pod App',
        theme: ThemeData(
          primaryColor: AppColors.appAccent,
          colorScheme: const ColorScheme.light(
            primary: AppColors.appPrimary,
            secondary: AppColors.appAccent,
          ),
        ),
        routerConfig: buildRouter(),
      );
}

import 'package:dhan_saarthi/features/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/basic_features.dart';
import '../core/theme/app_theme_data.dart';
import 'onboarding/onboarding_screen.dart';

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (_, widget) => GestureDetector(
          onTap: AppUtils.closeKeyboard,
          child: GetMaterialApp(
            builder: EasyLoading.init(
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!,
              ),
            ),
            darkTheme: AppThemeData.darkTheme,
            defaultTransition: Transition.cupertino,
            themeMode: ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            title: AppString.appName,
            home:
                isLoggedIn ? const DashboardScreen() : const OnboardingScreen(),
          ),
        ),
      );
}

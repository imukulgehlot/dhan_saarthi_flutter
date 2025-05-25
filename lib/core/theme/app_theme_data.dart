import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';
import '../constants/dimensions.dart';
import '../utils/style.dart';

class AppThemeData {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: const Color(0xff8C74FB),
    shadowColor: Colors.white38,
    splashColor: AppColors.primaryLightColor.withValues(alpha: 0.2),
    highlightColor: AppColors.primaryLightColor.withValues(alpha: 0.1),
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: AppColors.primaryColor,
    ),
    canvasColor: AppColors.backgroundColorDark,
    scaffoldBackgroundColor: AppColors.backgroundColorDark,
    cardColor: const Color(0xff202020),
    hintColor: AppColors.hintColor,
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      elevation: 0.0,
      color: AppColors.backgroundColorDark,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
      centerTitle: false,
    ),
    tabBarTheme: TabBarThemeData(
      splashFactory: NoSplash.splashFactory,
      overlayColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        // Use the default focused overlay color
        return states.contains(WidgetState.focused) ? null : Colors.transparent;
      }),
    ),
    navigationBarTheme: NavigationBarThemeData(
      iconTheme: WidgetStateProperty.all(const IconThemeData(
        color: Colors.white, // Set the color for your icons here
      )),
      backgroundColor: AppColors.backgroundColorDark,
      surfaceTintColor: AppColors.backgroundColorDark,
      labelTextStyle:
          WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return fontStyleSemiBold12.apply(color: AppColors.whiteColor);
        } else {
          return fontStyleRegular12.apply(color: AppColors.whiteColor);
        }
      }),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: Dimensions.h3),
        backgroundColor: const Color(0xff202020),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.r10)),
        side: const BorderSide(color: Colors.transparent, width: 0),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            overlayColor:
                WidgetStateProperty.all(AppColors.primaryLightColor))),
    dialogTheme:
        DialogThemeData(backgroundColor: Colors.white.withValues(alpha: 0.01)),
  );
}

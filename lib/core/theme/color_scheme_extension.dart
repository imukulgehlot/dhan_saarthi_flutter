import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

extension ColorSchemeExtension on ColorScheme {
  Color get textFieldColor => brightness == Brightness.light
      // ? const Color(0xffEDEDED)
      ? AppColors.textFieldColor
      : AppColors.textFieldColor;

  Color get tabBarBackgroundColor => brightness == Brightness.light
      ? Colors.grey.shade200
      : const Color(0xff202020);

  Color get textColor => brightness == Brightness.light
      ? AppColors.appNameBlackColor
      : AppColors.whiteColor;

  Color get iconColor =>
      brightness == Brightness.light ? const Color(0xff707070) : Colors.white;

  Color get hintTextColor => brightness == Brightness.light
      ? AppColors.hintColor
      : AppColors.hintColor;

  // Color get hintTextColor =>
  //     brightness == Brightness.light ? const Color(0xff707070) : Colors.white54;

  Color get likeButtonBorderColor => brightness == Brightness.light
      ? AppColors.likeButtonBorderColor
      : Colors.grey.shade900;

  Color get dialogBarrierColor => brightness == Brightness.light
      ? const Color(0x80000000)
      : Colors.white.withValues(alpha: 0.01);

  Color get dialogColor => brightness == Brightness.light
      ? AppColors.whiteColor
      : const Color(0xff161a1d);

  Color get buttonGrey => brightness == Brightness.light
      ? AppColors.signInModeButtonColor
      : AppColors.backgroundColorDark;

  Color get cardColor => brightness == Brightness.light
      ? const Color(0xff707070)
      : AppColors.signInModeButtonColor;

  Color get blueTextColor => brightness == Brightness.light
      ? AppColors.textBlueColor
      : AppColors.whiteColor;
}

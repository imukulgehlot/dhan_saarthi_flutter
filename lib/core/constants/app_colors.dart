import 'package:flutter/material.dart';

class AppColors {
  static Color shimmerBaseColor = Colors.grey.shade200;
  static Color shimmerHighLightColor = Colors.grey.shade400;

  static const Color primaryColor = Color(0xff0070DF);
  static const Color primaryLightColor = Color(0xff8CD1FB);
  static Color snackBarBackgroundColor =
      primaryLightColor.withValues(alpha: 0.9);
  static Color snackBarBorderColor = primaryColor;
  static const Color greyColor = Color(0xffCBCBCB);
  static const Color blackColor = Color(0xff000000);
  static const Color darkSmokeGray = Color(0x801E1E2C);
  static const Color whiteColor = Color(0xffffffff);
  static const Color textFieldColor = Color(0xff262626);
  static const Color backgroundColor = Color(0xffF3F5F6);
  static const Color backgroundColorDark = Color(0xff171616);

  static const Color dividerColor = Color(0xfff9f9f9);
  static Color textFieldBorderColor = primaryColor.withValues(alpha: 0.5);
  static Color redTextColor = const Color(0xFFEC817D);
  static Color cupertinoBlueColor = const Color(0xff0094ff);
  static Color hintColor = const Color(0xFF808080);

  static const Color textColor = whiteColor;
  static const Color textTitleColor = Color(0xff1A1A1A);
  static const Color textGreyColor = Color(0xff7c7c7c);
  static const Color borderColor = Color(0xff5D5D5D);
  static const Color greyDotColor = Color(0xffdddddd);
  static const Color appbarColor = whiteColor;
  static const Color greenHighlightColor = Color(0xff4CAF50);
  static const Color greyNotActiveColor = Color(0xff7F7F7F);
  static const Color themeGreen = Color(0xff21b451);
  static const Color themePink = Color(0xffFF385C);

  static const Color textBlueColor = Color(0xff0448AC);
  static const Color closeRedColor = Color(0xffd14141);

  static const Color signInModeButtonColor = Color(0xFFF8F8F8);

  static const Color likeButtonBorderColor = Color(0xFFF1F1F1);
  static const Color greyText = Color(0xFF888888);
  static const Color dateContainer = Color(0xFF3E6BA8);
  static const Color containerGrey = Color(0xFF454545);

  static const Color appNameBlackColor = Color(0xFF323232);
  static const Color greyHighlightColor = Color(0xFFB0B0B0);
  static const Color whiteHighlightColor = Color(0xFFF6F6F6);
  static const Color tagLineGreyColor = Color(0xFF636363);
  static const Color disabledButtonColor = Color(0xFF6D6D6D);
  static Color lossRedColor = const Color(0xFFDE504B);
  static const Color redTimerColor = Color(0xFFFA2C3B);
  static const Color borderRedColor = Color(0xFFFF3D3D);
  static Color yellowColor = const Color(0xFFFDA712);

  static const Color gradientBeginColor = Color(0xFF0883FD);
  static const Color gradientEndColor = Color(0xFF8CD1FB);

  // Gradients
  static LinearGradient lineChartGradient = LinearGradient(
    colors: [
      whiteColor.withValues(alpha: 0.1),
      whiteColor.withValues(alpha: 0.05),
      whiteColor.withValues(alpha: 0.0)
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

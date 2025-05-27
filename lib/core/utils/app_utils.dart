import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/auth/controller/sign_in_controller.dart';
import '../basic_features.dart';
import '../helpers/animation_helper.dart';
import '../widgets/custom_image.dart';
import 'custom_dialogs.dart';
import 'logger_util.dart';

void orientations() => SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

class AppUtils {
  static InputFormatter inputFormatter = InputFormatter();
  static RegExpression regExpression = RegExpression();

  static String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static Pattern phonePattern = r'(^[0-9 ]*$)';

  static void closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  static void closeApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    }
    exit(0);
  }

  static showSnackBar(
      {bool isSuccess = false,
      String? title,
      required String message,
      int durationMilliSecond = 4000}) {
    if (!Get.isSnackbarOpen) {
      Get.showSnackbar(
        GetSnackBar(
          borderColor: AppColors.primaryColor,
          borderWidth: 2,
          barBlur: 80,
          snackPosition: SnackPosition.TOP,
          maxWidth: Get.width * 0.92,
          borderRadius: Dimensions.r17,
          forwardAnimationCurve: CustomAnimationCurves.snackBarEaseOutBack,
          animationDuration: 800.milliseconds,
          backgroundColor: AppColors.snackBarBackgroundColor,
          duration: Duration(milliseconds: durationMilliSecond),
          margin: EdgeInsets.symmetric(horizontal: Dimensions.w8),
          messageText: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Action Icon, Title, Trailing Icon
              Row(
                children: [
                  // Action Icon
                  // Action Icon
                  CustomSvgAssetImage(
                    image: isSuccess
                        ? AppImages.icCheckCircle
                        : AppImages.icWarningCircle,
                    width: Dimensions.w30,
                    height: Dimensions.w30,
                  ),
                  // Title Text
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.w10),
                    child: Text(
                      title ??
                          (isSuccess
                              ? AppString.snackBarPositiveTitle.tr
                              : AppString.snackBarNegativeTitle.tr),
                      style: fontStyleMedium17.copyWith(
                          color: AppColors.blackColor),
                    ),
                  ),
                  Spacer(),
                ],
              ),

              // Message Text
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w40),
                child: Text(
                  message,
                  style: fontStyleLight15.copyWith(color: AppColors.blackColor),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  // Sign Out Dialogue
  static showSignOutDialogue() {
    CustomDialogs.showCustomDialog(
        icon: AppImages.icDialogueQuestion,
        title: AppString.areYouSure,
        contentText: AppString.areYouSureLogout,
        firstButtonFunction: () async {
          // Sign Out
          final signInController = SignInController();
          await signInController.signOutUser();
        },
        firstButtonText: AppString.yesLogout,
        secondButtonText: AppString.cancel);
  }

  static Color getRandomColor({bool dark = false}) {
    final Random random = Random();
    const int maxColorValue = 255;

    int randomColorComponent() => random.nextInt(maxColorValue);

    int randomRed = randomColorComponent();
    int randomGreen = randomColorComponent();
    int randomBlue = randomColorComponent();

    return dark
        ? Color.fromARGB(255, randomRed, randomGreen, randomBlue)
            .withValues(alpha: 0.35)
        : Color.fromARGB(255, randomRed, randomGreen, randomBlue);
  }

  static Future<void> openLink({required String link}) async {
    final Uri encodedURl = Uri.parse(link);

    try {
      await launchUrl(encodedURl, mode: LaunchMode.inAppWebView);
    } catch (e) {
      logger.e('Error launching URL: $e');
    }
  }

  static featureUnderDevelopment() =>
      AppUtils.showToast("Feature Under Development!");

  static showToast(val) => Fluttertoast.showToast(
      msg: val,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.blackColor,
      textColor: Colors.white,
      fontSize: 16.0);

  static Future<void> openUrl({required String url, Uri? uri}) async {
    try {
      bool launched = await launchUrl(uri ?? Uri.parse(url),
          mode: LaunchMode
              .externalNonBrowserApplication); // Launch the app if installed!

      if (!launched) {
        launchUrl(Uri.parse(url)); // Launch web view if app is not installed!
      }
    } catch (e) {
      launchUrl(
        Uri.parse(url),
      ); // Launch web view if app is not installed!
    }
  }


  static DateTime? backButtonPressedTime;

  // For Pop Scope
  static showExitPopScopePopup() {
    DateTime currentTime = DateTime.now();

    bool backButton = backButtonPressedTime == null ||
        currentTime.difference(backButtonPressedTime!) >
            const Duration(seconds: 3);

    if (backButton) {
      backButtonPressedTime = currentTime;
      AppUtils.showToast('Press again to exit');
    } else {
      SystemNavigator.pop();
    }
  }

  // Get 2 initials
  static String getInitials(String name) => name.isNotEmpty
      ? name.trim().split(' ').map((l) => l[0]).take(2).join().toUpperCase()
      : '';
}

class InputFormatter {
  FilteringTextInputFormatter get number =>
      FilteringTextInputFormatter.allow(RegExp(r"[0-9]"));
}

class RegExpression {
  RegExp phonePattern = RegExp(r'(^[0-9 ]*$)');
}

class FontAsset {
  static const String gilroy = "Gilroy";

  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

class MyDivider extends StatelessWidget {
  final double height;
  final Color? color;

  const MyDivider({super.key, this.height = 0, this.color});

  @override
  Widget build(BuildContext context) {
    return Divider(
        height: height, color: color ?? AppColors.disabledButtonColor);
  }
}
